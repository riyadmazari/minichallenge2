// lib/features/details/pages/tv_show_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/api/tmdb_repository.dart';
import '../../../core/models/tv_show.dart';
import '../widgets/cast_list.dart';
import '../widgets/info_section.dart';

class TVShowDetailScreen extends StatelessWidget {
  final int tvId;
  const TVShowDetailScreen({Key? key, required this.tvId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tmdbRepository = Provider.of<TMDBRepository>(context, listen: false);

    return FutureBuilder<TVShow>(
      future: tmdbRepository.getTVDetails(tvId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        } else if (snapshot.hasData) {
          final tvShow = snapshot.data!;
          final posterUrl = 'https://image.tmdb.org/t/p/w500${tvShow.posterPath}';

          return Scaffold(
            appBar: AppBar(
              title: Text(tvShow.name),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  posterUrl.isNotEmpty
                      ? Image.network(
                          posterUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            color: Colors.grey.shade300,
                            child: const Icon(Icons.broken_image),
                          ),
                        )
                      : Container(
                          height: 200,
                          color: Colors.grey.shade300,
                          child: const Center(child: Icon(Icons.image)),
                        ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: InfoSection(
                      title: tvShow.name,
                      overview: tvShow.overview,
                      releaseDate: tvShow.firstAirDate,
                      rating: tvShow.voteAverage,
                      genres: tvShow.genres, // Ensure genres are parsed correctly
                      runtime: tvShow.episodeRunTime != null && tvShow.episodeRunTime!.isNotEmpty
                          ? tvShow.episodeRunTime!.first
                          : 0,
                      director: tvShow.director, // Ensure `director` field is present
                      pegi: tvShow.pegiRating, // Ensure `pegiRating` field is present
                      isTV: true,
                      seasons: tvShow.numberOfSeasons,
                      episodes: tvShow.numberOfEpisodes,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CastList(cast: tvShow.cast.take(3).toList()), // Display top 3 cast members
                  ),
                ],
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(child: Text('No TV show found.')),
          );
        }
      },
    );
  }
}
