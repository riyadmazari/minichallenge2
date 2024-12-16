import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../models/watchlist_item.dart';

class WatchlistProvider with ChangeNotifier {
  List<WatchlistItem> _items = [];

  List<WatchlistItem> get items => _items;

  WatchlistProvider() {
    _loadWatchlist();
  }

  Future<void> _loadWatchlist() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('watchlist') ?? '[]';
    final jsonList = jsonDecode(data) as List;
    _items = jsonList.map((m) => WatchlistItem.fromMap(m)).toList();
    notifyListeners();
  }

  Future<void> _saveWatchlist() async {
    final prefs = await SharedPreferences.getInstance();
    final data = jsonEncode(_items.map((i) => i.toMap()).toList());
    await prefs.setString('watchlist', data);
  }

  Future<void> addToWatchlist(WatchlistItem item) async {
    if (!_items.any((w) => w.id == item.id && w.isMovie == item.isMovie)) {
      _items.add(item);
      await _saveWatchlist();
      notifyListeners();
    }
  }

  Future<void> removeFromWatchlist(int id, bool isMovie) async {
    _items.removeWhere((w) => w.id == id && w.isMovie == isMovie);
    await _saveWatchlist();
    notifyListeners();
  }
}
