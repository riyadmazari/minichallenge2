// lib/features/details/widgets/info_section.dart

import 'package:flutter/material.dart';

class InfoSection extends StatelessWidget {
  final String title;
  final String overview;
  final String? releaseDate;
  final double? rating;
  final List<String>? genres;
  final int? runtime;
  final String? director;
  final String? pegi;
  final bool isTV;
  final int? seasons;
  final int? episodes;

  const InfoSection({
    Key? key,
    required this.title,
    required this.overview,
    this.releaseDate,
    this.rating,
    this.genres,
    this.runtime,
    this.director,
    this.pegi,
    this.isTV = false,
    this.seasons,
    this.episodes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final genreText = genres != null && genres!.isNotEmpty ? genres!.join(', ') : 'No genres available';
    final ratingText = rating != null ? rating!.toStringAsFixed(1) : 'N/A';
    final dateText = releaseDate ?? 'N/A';
    final runtimeText = runtime != null && runtime! > 0 ? '$runtime min' : 'N/A';
    final directorText = director ?? 'N/A';
    final pegiText = pegi ?? 'N/A';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 8),
        Text('Release Date: $dateText'),
        Text('Rating: $ratingText'),
        Text('Director: $directorText'),
        Text('PEGI: $pegiText'),
        Text('Genres: $genreText'),
        if (!isTV) Text('Runtime: $runtimeText'),
        if (isTV && seasons != null && episodes != null)
          Text('Seasons: $seasons, Episodes: $episodes'),
        const SizedBox(height: 16),
        Text(overview),
      ],
    );
  }
}
