import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../models/rated_item.dart';

class RatedProvider with ChangeNotifier {
  List<RatedItem> _items = [];

  List<RatedItem> get items => _items;

  RatedProvider() {
    _loadRated();
  }

  Future<void> _loadRated() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('ratedItems') ?? '[]';
    final jsonList = jsonDecode(data) as List;
    _items = jsonList.map((m) => RatedItem.fromMap(m)).toList();
    notifyListeners();
  }

  Future<void> _saveRated() async {
    final prefs = await SharedPreferences.getInstance();
    final data = jsonEncode(_items.map((i) => i.toMap()).toList());
    await prefs.setString('ratedItems', data);
  }

  Future<void> addOrUpdateRating(RatedItem item) async {
    final index = _items.indexWhere((r) => r.id == item.id && r.isMovie == item.isMovie);
    if (index >= 0) {
      _items[index] = item;
    } else {
      _items.add(item);
    }
    await _saveRated();
    notifyListeners();
  }
}
