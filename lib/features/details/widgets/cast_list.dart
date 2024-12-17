// lib/features/details/widgets/cast_list.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // Ensure GoRouter is imported
import 'package:minichallenge2/core/models/actor.dart';

class CastList extends StatelessWidget {
  final List<CastMember> cast;

  const CastList({Key? key, required this.cast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (cast.isEmpty) {
      return const Text('No cast information available.');
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Cast', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 8),
        SizedBox(
          height: 150, // Adjust height as needed
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: cast.length,
            itemBuilder: (context, index) {
              final c = cast[index];
              final imageUrl = c.profilePath != null && c.profilePath!.isNotEmpty
                  ? 'https://image.tmdb.org/t/p/w200${c.profilePath}'
                  : null;

              return GestureDetector(
                onTap: () {
                  // Navigate to ActorDetailScreen using GoRouter's push
                  context.push('/actor/${c.id}');
                },
                child: Container(
                  width: 100,
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      if (imageUrl != null)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(
                            imageUrl,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              width: 80,
                              height: 80,
                              color: Colors.grey.shade300,
                              child: const Icon(Icons.broken_image),
                            ),
                          ),
                        )
                      else
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Icon(Icons.person, size: 40),
                        ),
                      const SizedBox(height: 8),
                      Text(
                        c.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
