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

  Future<void> loadTrending() async {
    isLoading = true;
    notifyListeners();
    try {
      final movies = await repository.fetchTrendingMovies();
      final tvShows = await repository.fetchTrendingTVShows();
      trendingMovies = movies;
      trendingTVShows = tvShows;
    } catch (e) {
      // Handle error gracefully, maybe set an error state
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
