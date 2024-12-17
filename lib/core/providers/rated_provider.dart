// lib/core/providers/rated_provider.dart

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import '../models/rating.dart';

class RatedProvider with ChangeNotifier {
  final Map<String, Map<int, Rating>> _ratings = {
    'movie': {},
    'tv': {},
    'actor': {},
  };

  RatedProvider() {
    _initRatings();
  }

  Future<void> _initRatings() async {
    final ratingsBox = Hive.box<Rating>('ratings');
    for (var rating in ratingsBox.values) {
      if (_ratings.containsKey(rating.category)) {
        _ratings[rating.category]![rating.id] = rating;
      }
    }
    notifyListeners();
  }

  // Get ratings by category
  List<Rating> getMovieRatings() => _ratings['movie']!.values.toList();
  List<Rating> getTvRatings() => _ratings['tv']!.values.toList();
  List<Rating> getActorRatings() => _ratings['actor']!.values.toList();

  Future<void> addOrUpdateRating(Rating rating) async {
    final ratingsBox = Hive.box<Rating>('ratings');
    if (_ratings[rating.category]!.containsKey(rating.id)) {
      // Update existing rating
      final existingRating = _ratings[rating.category]![rating.id]!;
      existingRating.userRating = rating.userRating;
      await existingRating.save();
      _ratings[rating.category]![rating.id] = existingRating;
    } else {
      // Add new rating
      await ratingsBox.add(rating);
      _ratings[rating.category]![rating.id] = rating;
    }
    notifyListeners();
  }

  double getRating(int id, String category) {
    final rating = _ratings[category]![id];
    return rating?.userRating ?? 0.0;
  }

  // Optional: Remove rating
  Future<void> removeRating(int id, String category) async {
    final ratingsBox = Hive.box<Rating>('ratings');
    final rating = _ratings[category]![id];
    if (rating != null) {
      await rating.delete();
      _ratings[category]!.remove(id);
      notifyListeners();
    }
  }
}
