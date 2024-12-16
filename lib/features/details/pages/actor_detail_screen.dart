import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/api/tmdb_repository.dart';
import '../../../core/models/actor.dart';

class ActorDetailScreen extends StatefulWidget {
  final int personId;
  const ActorDetailScreen({Key? key, required this.personId}) : super(key: key);

  @override
  State<ActorDetailScreen> createState() => _ActorDetailScreenState();
}

class _ActorDetailScreenState extends State<ActorDetailScreen> {
  Actor? actor;
  bool loading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadActor();
  }

  Future<void> _loadActor() async {
    final repo = context.read<TMDBRepository>();
    try {
      final result = await repo.getPersonDetails(widget.personId);
      setState(() {
        actor = result;
        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
        errorMessage = 'Failed to load actor details.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (errorMessage.isNotEmpty || actor == null) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(child: Text(errorMessage.isEmpty ? 'No actor found.' : errorMessage)),
      );
    }

    final imageUrl = actor!.profilePath != null
        ? 'https://image.tmdb.org/t/p/w300${actor!.profilePath}'
        : null;

    final age = actor!.age; // Assuming `age` is calculated in `Actor` model from `birthday`
    final knownCredits = actor!.knownCredits; // Assuming a list of known movie/TV items

    return Scaffold(
      appBar: AppBar(
        title: Text(actor!.name),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              if (imageUrl != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(imageUrl, height: 300, fit: BoxFit.cover),
                ),
              const SizedBox(height: 16),
              Text(
                actor!.name,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text('Age: $age'),
              const SizedBox(height: 16),
              Text(
                'Known For',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              if (knownCredits.isEmpty)
                const Text('No known credits available.')
              else
                Column(
                  children: knownCredits.take(3).map((credit) {
                    // credit could be movie or tv show, each with `title` or `name` and `posterPath`
                    final title = credit['title'] ?? credit['name'] ?? 'Untitled';
                    final posterPath = credit['poster_path'];
                    final posterUrl = posterPath != null 
                        ? 'https://image.tmdb.org/t/p/w200$posterPath'
                        : null;

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          if (posterUrl != null)
                            Image.network(posterUrl, width: 60, height: 90, fit: BoxFit.cover),
                          const SizedBox(width: 10),
                          Expanded(child: Text(title)),
                        ],
                      ),
                    );
                  }).toList(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
