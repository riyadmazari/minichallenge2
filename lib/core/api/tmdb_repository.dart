// lib/core/api/tmdb_repository.dart

import 'tmdb_api_service.dart';

import '../models/movie.dart';
import '../models/tv_show.dart';
import '../models/actor.dart';
import '../models/search_result.dart';

class TMDBRepository {
  final TMDBApiService apiService;
  TMDBRepository(this.apiService);

  Future<List<Movie>> fetchTrendingMovies() async {
    try {
      final response = await apiService.getTrending(mediaType: 'movie', timeWindow: 'day'); // Changed to 'day' as per user JS example
      if (response.statusCode == 200) {
        final results = (response.data['results'] as List)
            .map((m) => Movie.fromJson(m))
            .toList();
        // Now parse full details for each movie
        List<Movie> detailedMovies = [];
        for (var movie in results) {
          final detailedResponse = await apiService.getMovieDetails(movie.id);
          if (detailedResponse.statusCode == 200) {
            detailedMovies.add(Movie.fromFullJson(detailedResponse.data));
          }
        }
        return detailedMovies;
      } else {
        throw Exception('Failed to load trending movies');
      }
    } catch (e) {
      throw e;
    }
  }

  Future<List<TVShow>> fetchTrendingTVShows() async {
    try {
      final response = await apiService.getTrending(mediaType: 'tv', timeWindow: 'day'); // Changed to 'day' as per user JS example
      if (response.statusCode == 200) {
        final results = (response.data['results'] as List)
            .map((t) => TVShow.fromJson(t))
            .toList();
        // Now parse full details for each TV show
        List<TVShow> detailedTVShows = [];
        for (var tvShow in results) {
          final detailedResponse = await apiService.getTVDetails(tvShow.id);
          if (detailedResponse.statusCode == 200) {
            detailedTVShows.add(TVShow.fromFullJson(detailedResponse.data));
          }
        }
        return detailedTVShows;
      } else {
        throw Exception('Failed to load trending TV shows');
      }
    } catch (e) {
      throw e;
    }
  }

  Future<List<SearchResult>> searchAll(String query) async {
    try {
      final response = await apiService.search(query, type: 'multi');
      if (response.statusCode == 200) {
        final results = response.data['results'] as List;
        return results.map((r) => SearchResult.fromJson(r)).toList();
      } else {
        throw Exception('Failed to perform search');
      }
    } catch (e) {
      throw e;
    }
  }

  Future<Movie> getMovieDetails(int movieId) async {
    try {
      final response = await apiService.getMovieDetails(movieId);
      if (response.statusCode == 200) {
        return Movie.fromFullJson(response.data);
      } else {
        throw Exception('Failed to load movie details');
      }
    } catch (e) {
      throw e;
    }
  }

  Future<TVShow> getTVDetails(int tvId) async {
    try {
      final response = await apiService.getTVDetails(tvId);
      if (response.statusCode == 200) {
        return TVShow.fromFullJson(response.data);
      } else {
        throw Exception('Failed to load TV show details');
      }
    } catch (e) {
      throw e;
    }
  }

  Future<Actor> getPersonDetails(int personId) async {
    try {
      final response = await apiService.getPersonDetails(personId);
      if (response.statusCode == 200) {
        return Actor.fromFullJson(response.data);
      } else {
        throw Exception('Failed to load actor details');
      }
    } catch (e) {
      throw e;
    }
  }
}
