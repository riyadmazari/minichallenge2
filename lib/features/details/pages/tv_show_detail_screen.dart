import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/api/tmdb_repository.dart';
import '../../../core/models/tv_show.dart';
import '../widgets/cast_list.dart';
import '../widgets/info_section.dart';

class TVShowDetailScreen extends StatefulWidget {
  final int tvId;
  const TVShowDetailScreen({Key? key, required this.tvId}) : super(key: key);

  @override
  State<TVShowDetailScreen> createState() => _TVShowDetailScreenState();
}

class _TVShowDetailScreenState extends State<TVShowDetailScreen> {
  TVShow? tvShow;
  bool loading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadTVShow();
  }

  Future<void> _loadTVShow() async {
    final repo = context.read<TMDBRepository>();
    try {
      final result = await repo.getTVDetails(widget.tvId);
      setState(() {
        tvShow = result;
        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
        errorMessage = 'Failed to load TV show details.';
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

    if (errorMessage.isNotEmpty || tvShow == null) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(child: Text(errorMessage.isEmpty ? 'No TV show found.' : errorMessage)),
      );
    }

    final posterUrl = 'https://image.tmdb.org/t/p/w500${tvShow!.posterPath}';

    return Scaffold(
      appBar: AppBar(
        title: Text(tvShow!.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            posterUrl.isNotEmpty
                ? Image.network(posterUrl, fit: BoxFit.cover)
                : Container(
                    height: 200,
                    color: Colors.grey.shade300,
                    child: const Center(child: Icon(Icons.image)),
                  ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: InfoSection(
                title: tvShow!.name,
                overview: tvShow!.overview,
                releaseDate: tvShow!.firstAirDate,
                rating: tvShow!.voteAverage,
                genres: tvShow!.genres,
                runtime: tvShow!.episodeRunTime != null && tvShow!.episodeRunTime!.isNotEmpty ? tvShow!.episodeRunTime!.first : 0,
                director: tvShow!.director, // If available from full details
                pegi: tvShow!.pegiRating, // If available
                isTV: true,
                seasons: tvShow!.numberOfSeasons,
                episodes: tvShow!.numberOfEpisodes,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CastList(cast: tvShow!.cast.take(3).toList()),
            ),
          ],
        ),
      ),
    );
  }
}
