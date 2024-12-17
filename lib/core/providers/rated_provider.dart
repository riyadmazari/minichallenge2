// lib/core/providers/rated_provider.dart

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import '../models/rating.dart';

class RatedProvider with ChangeNotifier {
  List<Rating> _ratings = [];
  late Box<Rating> _ratingsBox;

  List<Rating> get items => _ratings;

  RatedProvider() {
    _initRatings();
  }

  Future<void> _initRatings() async {
    _ratingsBox = Hive.box<Rating>('ratings');
    _ratings = _ratingsBox.values.toList();
    notifyListeners();
  }

  Future<void> addOrUpdateRating(Rating rating) async {
    // Check if rating exists
    final index = _ratings.indexWhere(
      (r) => r.id == rating.id && r.isMovie == rating.isMovie,
    );
    if (index != -1) {
      // Update existing rating
      final key = _ratingsBox.keyAt(index);
      await _ratingsBox.put(key, rating);
      _ratings[index] = rating;
    } else {
      // Add new rating
      await _ratingsBox.add(rating);
      _ratings = _ratingsBox.values.toList();
    }
    notifyListeners();
  }

  double getRating(int id, bool isMovie) {
    final rating = _ratings.firstWhere(
      (r) => r.id == id && r.isMovie == isMovie,
      orElse: () => Rating(
        id: id,
        isMovie: isMovie,
        title: '',
        posterPath: '',
        userRating: 0.0,
      ),
    );
    return rating.userRating;
  }

  Future<void> removeRating(int id, bool isMovie) async {
    final key = _ratingsBox.keys.firstWhere(
      (k) {
        final r = _ratingsBox.get(k);
        return r != null && r.id == id && r.isMovie == isMovie;
      },
      orElse: () => null,
    );
    if (key != null) {
      await _ratingsBox.delete(key);
      _ratings = _ratingsBox.values.toList();
      notifyListeners();
    }
  }
}
