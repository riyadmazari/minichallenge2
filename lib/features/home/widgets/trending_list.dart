// lib/features/home/widgets/trending_list.dart

import 'package:flutter/material.dart';
import '../../../core/models/movie.dart';
import '../../../core/models/tv_show.dart';
import '../../../core/utils/constants.dart';
import '../../details/pages/movie_detail_screen.dart';
import '../../details/pages/tv_show_detail_screen.dart';

class TrendingList extends StatelessWidget {
  final List<dynamic> items;
  final bool isMovie;

  const TrendingList({
    Key? key,
    required this.items,
    required this.isMovie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const Center(child: Text('No items available.'));
    }

    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (_, index) {
          final item = items[index];

          String title = '';
          int id = 0;
          String posterPath = '';

          if (isMovie && item is Movie) {
            title = item.title;
            id = item.id;
            posterPath = item.posterPath;
          } else if (!isMovie && item is TVShow) {
            title = item.name;
            id = item.id;
            posterPath = item.posterPath;
          } else {
            return const SizedBox.shrink(); // Invalid item type
          }

          final posterUrl = posterPath.isNotEmpty
              ? '$BASE_IMAGE_URL/w200$posterPath'
              : '';

          return GestureDetector(
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
            child: Container(
              width: 140,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AspectRatio(
                    aspectRatio: 2 / 3,
                    child: posterUrl.isNotEmpty
                        ? Image.network(
                            posterUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              color: Colors.grey.shade300,
                              child: const Icon(Icons.broken_image),
                            ),
                          )
                        : Container(
                            color: Colors.grey.shade300,
                            child: const Center(child: Icon(Icons.image)),
                          ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
