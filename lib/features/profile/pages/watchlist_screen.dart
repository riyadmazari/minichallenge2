import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../../../core/providers/watchlist_provider.dart';

class WatchlistScreen extends StatelessWidget {
  const WatchlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final watchlistProvider = context.watch<WatchlistProvider>();
    final items = watchlistProvider.items; // items could be a mix of movies and tv shows

    return Scaffold(
      appBar: AppBar(title: const Text('My Watchlist')),
      body: items.isEmpty
          ? const Center(child: Text('Your watchlist is empty.'))
          : ListView.builder(
              itemCount: items.length,
              itemBuilder: (_, i) {
                final item = items[i];
                final isMovie = item.isMovie; // Assuming the model has a way to know if it's movie or tv
                final title = item.title;
                final posterUrl = 'https://image.tmdb.org/t/p/w92${item.posterPath}';
                final route = isMovie ? '/movie/${item.id}' : '/tv/${item.id}';

                return ListTile(
                  leading: Image.network(posterUrl, width: 50, fit: BoxFit.cover),
                  title: Text(title),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      watchlistProvider.removeFromWatchlist(item.id, isMovie);
                    },
                  ),
                  onTap: () => context.push(route),
                );
              },
            ),
    );
  }
}
