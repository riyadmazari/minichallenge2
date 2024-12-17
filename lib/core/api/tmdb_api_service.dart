// lib/core/api/tmdb_api_service.dart

import 'package:dio/dio.dart';
import '../utils/constants.dart';

class TMDBApiService {
  final Dio _dio;

  TMDBApiService() : _dio = Dio() {
    _dio.options.baseUrl = 'https://api.themoviedb.org/3';
    _dio.options.headers['Authorization'] = 'Bearer $TMDB_ACCESS_TOKEN';
    _dio.options.headers['Content-Type'] = 'application/json;charset=utf-8';
    _dio.options.headers['accept'] = 'application/json';

    // Add logging interceptor for debugging
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      logPrint: (obj) => print(obj),
    ));
  }

  Future<Response> getTrending({String mediaType = 'movie', String timeWindow = 'day'}) {
    return _dio.get('/trending/$mediaType/$timeWindow', queryParameters: {
      'language': DEFAULT_LANG,
    });
  }

  Future<Response> search(String query, {String type = 'multi'}) {
    return _dio.get('/search/$type', queryParameters: {
      'query': query,
      'language': DEFAULT_LANG,
    });
  }

  Future<Response> getMovieDetails(int movieId) {
    return _dio.get('/movie/$movieId', queryParameters: {
      'append_to_response': 'credits,release_dates',
      'language': DEFAULT_LANG,
    });
  }

  Future<Response> getTVDetails(int tvId) {
    return _dio.get('/tv/$tvId', queryParameters: {
      'append_to_response': 'credits,content_ratings',
      'language': DEFAULT_LANG,
    });
  }

  Future<Response> getPersonDetails(int personId) {
    return _dio.get('/person/$personId', queryParameters: {
      'append_to_response': 'movie_credits,tv_credits',
      'language': DEFAULT_LANG,
    });
  }
}
