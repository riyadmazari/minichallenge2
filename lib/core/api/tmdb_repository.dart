import 'tmdb_api_service.dart';
import '../models/movie.dart';
import '../models/tv_show.dart';
import '../models/actor.dart';
import '../models/search_result.dart';
import 'package:flutter/foundation.dart';

class TMDBRepository {
  final TMDBApiService apiService;
  TMDBRepository(this.apiService);

  Future<List<Movie>> fetchTrendingMovies() async {
    final response = await apiService.getTrending(mediaType: 'movie');
    final results = (response.data['results'] as List)
        .map((m) => Movie.fromJson(m))
        .toList();
    if (kDebugMode) {
      print('Movie Trending Response: ${response.statusCode} - ${response.data}');
    }
    return results;
  }

  Future<List<TVShow>> fetchTrendingTVShows() async {
    final response = await apiService.getTrending(mediaType: 'tv');
    final results = (response.data['results'] as List)
        .map((t) => TVShow.fromJson(t))
        .toList();
    return results;
  }

  Future<List<SearchResult>> searchAll(String query) async {
    final response = await apiService.search(query);
    final results = response.data['results'] as List;
    return results.map((r) => SearchResult.fromJson(r)).toList();
  }

  Future<Movie> getMovieDetails(int movieId) async {
    final response = await apiService.getMovieDetails(movieId);
    return Movie.fromFullJson(response.data);
  }

  Future<TVShow> getTVDetails(int tvId) async {
    final response = await apiService.getTVDetails(tvId);
    return TVShow.fromFullJson(response.data);
  }

  Future<Actor> getPersonDetails(int personId) async {
    final response = await apiService.getPersonDetails(personId);
    return Actor.fromFullJson(response.data);
  }
}
