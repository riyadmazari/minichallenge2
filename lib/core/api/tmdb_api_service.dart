import 'package:dio/dio.dart';
import '../utils/constants.dart';

class TMDBApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': TMDB_API_KEY,
        'language': 'en-US',
      },
    ),
  );

  Future<Response> getTrending({String mediaType = 'all', String timeWindow = 'week'}) {
    return _dio.get('/trending/$mediaType/$timeWindow');
  }

  Future<Response> search(String query, {String type = 'multi'}) {
    return _dio.get('/search/$type', queryParameters: {'query': query});
  }

  Future<Response> getMovieDetails(int movieId) {
    return _dio.get('/movie/$movieId', queryParameters: {
      'append_to_response': 'credits,release_dates'
    });
  }

  Future<Response> getTVDetails(int tvId) {
    return _dio.get('/tv/$tvId', queryParameters: {
      'append_to_response': 'credits,content_ratings'
    });
  }

  Future<Response> getPersonDetails(int personId) {
    return _dio.get('/person/$personId', queryParameters: {
      'append_to_response': 'movie_credits,tv_credits'
    });
  }

  // For genres you may call /genre/movie/list or /genre/tv/list if needed
}
