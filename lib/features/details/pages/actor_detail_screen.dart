// lib/features/details/pages/actor_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:minichallenge2/core/models/rating.dart';
import 'package:provider/provider.dart';
import '../../../core/api/tmdb_repository.dart';
import '../../../core/models/actor.dart';
import '../../../core/providers/rated_provider.dart';
import '../../details/widgets/cast_list.dart';

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
    final knownCredits = actor!.knownCredits; // List<Map<String, dynamic>>

    // Map knownCredits to List<CastMember>
    List<CastMember> castMembers = knownCredits.take(3).map((credit) {
      return CastMember(
        id: credit['id'] ?? 0, // Ensure 'id' is present in credit
        name: credit['title'] ?? credit['name'] ?? 'Untitled',
        profilePath: credit['poster_path'],
        character: credit['media_type'] == 'movie' ? 'Movie' : 'TV Show', // Set character as media type
      );
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(actor!.name),
        // The AppBar automatically provides a back button if there's a previous route
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
                )
              else
                Container(
                  height: 300,
                  color: Colors.grey.shade300,
                  child: const Center(child: Icon(Icons.image, size: 100)),
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
                'Biography',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(actor!.biography.isNotEmpty ? actor!.biography : 'No biography available.'),
              const SizedBox(height: 16),
              Text(
                'Known For',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              if (castMembers.isEmpty)
                const Text('No known credits available.')
              else
                CastList(cast: castMembers),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  _showRatingDialog(context);
                },
                child: const Text('Rate this Actor'),
              ),
              const SizedBox(height: 20),
              // Removed the custom back button here
            ],
          ),
        ),
      ),
    );
  }

  void _showRatingDialog(BuildContext context) {
    final ratedProvider = Provider.of<RatedProvider>(context, listen: false);
    double _currentRating = ratedProvider.getRating(widget.personId, 'actor'); // Updated to include category

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Rate Actor: ${actor!.name}'),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Your Rating: ${_currentRating > 0 ? _currentRating.toInt() : 'Not rated'}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  Slider(
                    value: _currentRating > 0 ? _currentRating : 5,
                    min: 1,
                    max: 10,
                    divisions: 9,
                    label: _currentRating > 0 ? _currentRating.toInt().toString() : '5',
                    onChanged: (double value) {
                      setState(() {
                        _currentRating = value;
                      });
                    },
                  ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_currentRating > 0) {
                  ratedProvider.addOrUpdateRating(
                    Rating(
                      id: actor!.id,
                      category: 'actor', // Added category
                      title: actor!.name,
                      posterPath: actor!.profilePath ?? '',
                      userRating: _currentRating,
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Rating saved')),
                  );
                }
                Navigator.of(context).pop(); // Close dialog
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }
}
