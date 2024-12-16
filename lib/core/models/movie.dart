import 'actor.dart'; // for cast members

class Movie {
  final int id;
  final String title;
  final String posterPath;
  final String overview;
  final String releaseDate;
  final double rating;
  final List<String> genres;
  final int runtime;
  final String? director;
  final String? pegiRating;
  final List<CastMember> cast;

  Movie({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
    required this.releaseDate,
    required this.rating,
    required this.genres,
    required this.runtime,
    this.director,
    this.pegiRating,
    required this.cast,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      posterPath: json['poster_path'] ?? '',
      overview: json['overview'] ?? '',
      releaseDate: json['release_date'] ?? '',
      rating: (json['vote_average'] ?? 0).toDouble(),
      genres: [], // will be updated in fromFullJson
      runtime: 0, // will be updated in fromFullJson
      cast: [],
    );
  }

  factory Movie.fromFullJson(Map<String, dynamic> json) {
    // Parse genres
    List<String> parsedGenres = [];
    if (json['genres'] != null) {
      parsedGenres = (json['genres'] as List).map((g) => g['name'] as String).toList();
    }

    // Parse runtime
    final runtime = json['runtime'] ?? 0;

    // Parse director
    String? director;
    if (json['credits'] != null && json['credits']['crew'] is List) {
      final crew = json['credits']['crew'] as List;
      final dir = crew.firstWhere((c) => c['job'] == 'Director', orElse: () => null);
      if (dir != null) {
        director = dir['name'];
      }
    }

    // Parse cast (first 3 or more)
    List<CastMember> cast = [];
    if (json['credits'] != null && json['credits']['cast'] is List) {
      cast = (json['credits']['cast'] as List)
          .map((c) => CastMember.fromJson(c))
          .toList();
    }

    // Parse PEGI rating (movie): from release_dates
    // We look for US or first country to get certification
    String? pegiRating;
    if (json['release_dates'] != null && json['release_dates']['results'] is List) {
      final results = json['release_dates']['results'] as List;
      for (var countryInfo in results) {
        if (countryInfo['release_dates'] is List && (countryInfo['release_dates'] as List).isNotEmpty) {
          final release = (countryInfo['release_dates'] as List).first;
          if (release['certification'] != null && (release['certification'] as String).isNotEmpty) {
            pegiRating = release['certification'];
            break;
          }
        }
      }
    }

    return Movie(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      posterPath: json['poster_path'] ?? '',
      overview: json['overview'] ?? '',
      releaseDate: json['release_date'] ?? '',
      rating: (json['vote_average'] ?? 0).toDouble(),
      genres: parsedGenres,
      runtime: runtime,
      director: director,
      pegiRating: pegiRating,
      cast: cast,
    );
  }
}
