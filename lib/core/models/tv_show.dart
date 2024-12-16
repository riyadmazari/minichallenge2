import 'actor.dart';

class TVShow {
  final int id;
  final String name;
  final String posterPath;
  final String overview;
  final String firstAirDate;
  final double voteAverage;
  final List<String> genres;
  final int numberOfSeasons;
  final int numberOfEpisodes;
  final List<int>? episodeRunTime;
  final String? director; // Not always available for TV; we try to find a "Director" from credits
  final String? pegiRating;
  final List<CastMember> cast;

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
    this.episodeRunTime,
    this.director,
    this.pegiRating,
    required this.cast,
  });

  factory TVShow.fromJson(Map<String, dynamic> json) {
    return TVShow(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      posterPath: json['poster_path'] ?? '',
      overview: json['overview'] ?? '',
      firstAirDate: json['first_air_date'] ?? '',
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
      genres: [],
      numberOfSeasons: json['number_of_seasons'] ?? 0,
      numberOfEpisodes: json['number_of_episodes'] ?? 0,
      episodeRunTime: [],
      cast: [],
    );
  }

  factory TVShow.fromFullJson(Map<String, dynamic> json) {
    // Parse genres
    List<String> parsedGenres = [];
    if (json['genres'] != null) {
      parsedGenres = (json['genres'] as List).map((g) => g['name'] as String).toList();
    }

    // Parse runtime (episode_run_time)
    List<int> runtime = [];
    if (json['episode_run_time'] != null && json['episode_run_time'] is List) {
      runtime = (json['episode_run_time'] as List).map((r) => r as int).toList();
    }

    // Parse director from crew if any
    String? director;
    if (json['credits'] != null && json['credits']['crew'] is List) {
      final crew = json['credits']['crew'] as List;
      final dir = crew.firstWhere((c) => c['job'] == 'Director', orElse: () => null);
      if (dir != null) director = dir['name'];
    }

    // Parse cast
    List<CastMember> cast = [];
    if (json['credits'] != null && json['credits']['cast'] is List) {
      cast = (json['credits']['cast'] as List)
          .map((c) => CastMember.fromJson(c))
          .toList();
    }

    // PEGI for TV: from content_ratings
    String? pegiRating;
    if (json['content_ratings'] != null && json['content_ratings']['results'] is List) {
      final results = json['content_ratings']['results'] as List;
      if (results.isNotEmpty) {
        // Try to find a rating, e.g. US or first available
        final ratingInfo = results.firstWhere((r) => r['iso_3166_1'] == 'US', orElse: () => results.first);
        if (ratingInfo != null && ratingInfo['rating'] != null && (ratingInfo['rating'] as String).isNotEmpty) {
          pegiRating = ratingInfo['rating'];
        }
      }
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
      episodeRunTime: runtime,
      director: director,
      pegiRating: pegiRating,
      cast: cast,
    );
  }
}
