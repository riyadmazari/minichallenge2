import 'package:flutter/material.dart';

class CastList extends StatelessWidget {
  final List<dynamic> cast; 
  // cast should be a list of cast members with fields:
  // `name`, `profilePath`, and maybe `character`

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
            final imageUrl = c.profilePath != null 
                ? 'https://image.tmdb.org/t/p/w92${c.profilePath}' 
                : null;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  if (imageUrl != null)
                    Image.network(imageUrl, width: 50, height: 50, fit: BoxFit.cover),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text('${c.name} as ${c.character ?? ''}'),
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
