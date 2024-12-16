import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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

          final title = isMovie ? item.title : item.name;
          final id = item.id;
          final route = isMovie ? '/movie/$id' : '/tv/$id';
          final posterUrl = 'https://image.tmdb.org/t/p/w200${item.posterPath}';

          return GestureDetector(
            onTap: () => context.push(route),
            child: Container(
              width: 140,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AspectRatio(
                    aspectRatio: 2/3,
                    child: posterUrl.isNotEmpty
                        ? Image.network(
                            posterUrl,
                            fit: BoxFit.cover,
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
