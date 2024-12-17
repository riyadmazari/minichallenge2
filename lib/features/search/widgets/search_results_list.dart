// lib/features/search/widgets/search_results_list.dart

import 'package:flutter/material.dart';
import '../../../core/models/search_result.dart';
import '../../details/pages/movie_detail_screen.dart';
import '../../details/pages/tv_show_detail_screen.dart';
import '../../../core/utils/constants.dart';

class SearchResultsList extends StatelessWidget {
  final List<SearchResult> results;

  const SearchResultsList({Key? key, required this.results}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (results.isEmpty) {
      return const Center(child: Text('No results found.'));
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (_, index) {
        final result = results[index];
        final isMovie = result.mediaType == 'movie';
        final title = isMovie ? result.name : result.name;
        final id = result.id;
        final posterPath = isMovie ? result.posterPath : result.posterPath; // Adjust if different for TV

        final posterUrl = (posterPath != null && posterPath.isNotEmpty)
            ? '$BASE_IMAGE_URL/w200$posterPath'
            : '';

        return ListTile(
          leading: posterUrl.isNotEmpty
              ? Image.network(
                  posterUrl,
                  width: 50,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 50,
                    color: Colors.grey.shade300,
                    child: const Icon(Icons.broken_image),
                  ),
                )
              : Container(
                  width: 50,
                  color: Colors.grey.shade300,
                  child: const Icon(Icons.image),
                ),
          title: Text(title),
          subtitle: Text(isMovie ? 'Movie' : 'TV Show'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => isMovie
                    ? MovieDetailScreen(movieId: id)
                    : TVShowDetailScreen(tvId: id),
              ),
            );
          },
        );
      },
    );
  }
}
