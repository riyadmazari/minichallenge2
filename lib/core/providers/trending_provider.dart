import 'package:flutter/foundation.dart';
import '../models/movie.dart';
import '../models/tv_show.dart';
import '../api/tmdb_repository.dart';

class TrendingProvider with ChangeNotifier {
  final TMDBRepository repository;
  TrendingProvider(this.repository);

  List<Movie> trendingMovies = [];
  List<TVShow> trendingTVShows = [];
  bool isLoading = false;
  String errorMessage = '';

  Future<void> loadTrending() async {
    isLoading = true;
    errorMessage = '';
    notifyListeners();
    try {
      final movies = await repository.fetchTrendingMovies();
      final tvShows = await repository.fetchTrendingTVShows();
      trendingMovies = movies;
      trendingTVShows = tvShows;
    } catch (e) {
      errorMessage = 'Failed to load trending items.';
      print('TrendingProvider Error: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
