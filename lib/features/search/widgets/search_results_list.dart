import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/models/search_result.dart';

class SearchResultsList extends StatelessWidget {
  final List<SearchResult> results;

  const SearchResultsList({Key? key, required this.results}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (results.isEmpty) {
      return const Center(child: Text('No results'));
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (_, i) {
        final result = results[i];
        final posterUrl = result.posterPath != null && result.posterPath!.isNotEmpty
            ? 'https://image.tmdb.org/t/p/w92${result.posterPath}'
            : null;

        return ListTile(
          leading: posterUrl != null
              ? Image.network(posterUrl, width: 50, fit: BoxFit.cover)
              : const Icon(Icons.image),
          title: Text(result.name),
          subtitle: Text(result.mediaType),
          onTap: () {
            if (result.mediaType == 'movie') {
              context.push('/movie/${result.id}');
            } else if (result.mediaType == 'tv') {
              context.push('/tv/${result.id}');
            } else if (result.mediaType == 'person') {
              context.push('/actor/${result.id}');
            }
          },
        );
      },
    );
  }
}
