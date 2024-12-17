// lib/features/details/widgets/cast_list.dart

import 'package:flutter/material.dart';
import '../../../core/models/actor.dart'; // Ensure correct import path

class CastList extends StatelessWidget {
  final List<CastMember> cast; // Changed from List<dynamic> to List<CastMember>

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
        Column(
          children: cast.map((c) {
            final imageUrl = c.profilePath != null && c.profilePath!.isNotEmpty
                ? 'https://image.tmdb.org/t/p/w92${c.profilePath}'
                : '';
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  if (imageUrl.isNotEmpty)
                    Image.network(
                      imageUrl,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: 50,
                        height: 50,
                        color: Colors.grey.shade300,
                        child: const Icon(Icons.broken_image),
                      ),
                    )
                  else
                    Container(
                      width: 50,
                      height: 50,
                      color: Colors.grey.shade300,
                      child: const Icon(Icons.person),
                    ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      '${c.name} as ${c.character ?? 'Unknown'}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
