import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../../../core/providers/rated_provider.dart';

class RatedListScreen extends StatelessWidget {
  const RatedListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ratedProvider = context.watch<RatedProvider>();
    final items = ratedProvider.items; // items with user ratings

    return Scaffold(
      appBar: AppBar(title: const Text('My Rated Movies/TV Shows')),
      body: items.isEmpty
          ? const Center(child: Text('No rated items found.'))
          : ListView.builder(
              itemCount: items.length,
              itemBuilder: (_, i) {
                final item = items[i];
                final isMovie = item.isMovie;
                final title = item.title;
                final posterUrl = 'https://image.tmdb.org/t/p/w92${item.posterPath}';
                final route = isMovie ? '/movie/${item.id}' : '/tv/${item.id}';

                return ListTile(
                  leading: Image.network(posterUrl, width: 50, fit: BoxFit.cover),
                  title: Text(title),
                  subtitle: Text('Your Rating: ${item.userRating}/10'),
                  onTap: () => context.push(route),
                );
              },
            ),
    );
  }
}
