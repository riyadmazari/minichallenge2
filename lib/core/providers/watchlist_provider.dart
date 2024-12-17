// lib/core/providers/watchlist_provider.dart

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import '../models/watchlist_item.dart';

class WatchlistProvider with ChangeNotifier {
  List<WatchlistItem> _items = [];
  late Box<WatchlistItem> _watchlistBox;

  List<WatchlistItem> get items => _items;

  WatchlistProvider() {
    _initWatchlist();
  }

  Future<void> _initWatchlist() async {
    _watchlistBox = Hive.box<WatchlistItem>('watchlist');
    _items = _watchlistBox.values.toList();
    notifyListeners();
  }

  Future<void> addToWatchlist(WatchlistItem item) async {
    if (!_items.any((w) => w.id == item.id && w.isMovie == item.isMovie)) {
      await _watchlistBox.add(item);
      _items = _watchlistBox.values.toList();
      notifyListeners();
    }
  }

  Future<void> removeFromWatchlist(int id, bool isMovie) async {
    final key = _watchlistBox.keys.firstWhere(
      (k) {
        final w = _watchlistBox.get(k);
        return w != null && w.id == id && w.isMovie == isMovie;
      },
      orElse: () => null,
    );
    if (key != null) {
      await _watchlistBox.delete(key);
      _items = _watchlistBox.values.toList();
      notifyListeners();
    }
  }

  bool isInWatchlist(int id, bool isMovie) {
    return _items.any((w) => w.id == id && w.isMovie == isMovie);
  }
}
