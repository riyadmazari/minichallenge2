// lib/core/models/tv_show.dart

import 'package:hive/hive.dart';
import 'actor.dart';

part 'tv_show.g.dart'; // Required for Hive code generation

@HiveType(typeId: 1)
class TVShow extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String posterPath;

  @HiveField(3)
  final String overview;

  @HiveField(4)
  final String firstAirDate;

  @HiveField(5)
  final double voteAverage;

  @HiveField(6)
  final List<String> genres;

  @HiveField(7)
  final int numberOfSeasons;

  @HiveField(8)
  final int numberOfEpisodes;

  @HiveField(9)
  final List<CastMember> cast;

  @HiveField(10)
  final String? director;

  @HiveField(11)
  final String? pegiRating;

  @HiveField(12)
  final List<int> episodeRunTime;

  TVShow({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.overview,
    required this.firstAirDate,
    required this.voteAverage,
    required this.genres,
    required this.numberOfSeasons,
    required this.numberOfEpisodes,
    required this.cast,
    this.director,
    this.pegiRating,
    required this.episodeRunTime,
  });

  factory TVShow.fromJson(Map<String, dynamic> json) {
    return TVShow(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      posterPath: json['poster_path'] ?? '',
      overview: json['overview'] ?? '',
      firstAirDate: json['first_air_date'] ?? '',
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
      genres: [], // To be filled in fromFullJson
      numberOfSeasons: json['number_of_seasons'] ?? 0,
      numberOfEpisodes: json['number_of_episodes'] ?? 0,
      cast: [],
      episodeRunTime: [],
    );
  }

  factory TVShow.fromFullJson(Map<String, dynamic> json) {
    // Parse genres
    List<String> parsedGenres = [];
    if (json['genres'] != null) {
      parsedGenres = (json['genres'] as List).map((g) => g['name'] as String).toList();
    }

    // Parse episode run time
    List<int> runtime = [];
    if (json['episode_run_time'] != null && json['episode_run_time'] is List) {
      runtime = (json['episode_run_time'] as List).map((r) => r as int).toList();
    }

    // Parse director from credits
    String? director;
    if (json['credits'] != null && json['credits']['crew'] is List) {
      final crew = json['credits']['crew'] as List;
      final directorCrew = crew.firstWhere(
        (c) => c['job'] == 'Director',
        orElse: () => null,
      );
      if (directorCrew != null) {
        director = directorCrew['name'];
      }
    }

    // Parse PEGI rating from content_ratings
    String? pegiRating;
    if (json['content_ratings'] != null && json['content_ratings']['results'] is List) {
      final results = json['content_ratings']['results'] as List;
      if (results.isNotEmpty) {
        // Try to find a rating, e.g., US or first available
        final ratingInfo = results.firstWhere(
          (r) => r['iso_3166_1'] == 'US',
          orElse: () => results.first,
        );
        if (ratingInfo != null &&
            ratingInfo['rating'] != null &&
            (ratingInfo['rating'] as String).isNotEmpty) {
          pegiRating = ratingInfo['rating'];
        }
      }
    }

    // Parse cast (first 5)
    List<CastMember> cast = [];
    if (json['credits'] != null && json['credits']['cast'] is List) {
      cast = (json['credits']['cast'] as List)
          .map((c) => CastMember.fromJson(c))
          .take(5)
          .toList();
    }

    return TVShow(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      posterPath: json['poster_path'] ?? '',
      overview: json['overview'] ?? '',
      firstAirDate: json['first_air_date'] ?? '',
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
      genres: parsedGenres,
      numberOfSeasons: json['number_of_seasons'] ?? 0,
      numberOfEpisodes: json['number_of_episodes'] ?? 0,
      cast: cast,
      director: director,
      pegiRating: pegiRating,
      episodeRunTime: runtime,
    );
  }
}
