import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api/tmdb_repository.dart';
import '../models/search_result.dart';

class SearchProvider with ChangeNotifier {
  final TMDBRepository repository;
  List<String> searchHistory = [];
  List<SearchResult> currentResults = [];
  bool isLoading = false;

  SearchProvider(this.repository) {
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    searchHistory = prefs.getStringList('searchHistory') ?? [];
    notifyListeners();
  }

  Future<void> _saveHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('searchHistory', searchHistory);
  }

  Future<void> saveSearchTerm(String term) async {
    if (term.isEmpty) return;
    searchHistory.removeWhere((t) => t == term);
    searchHistory.insert(0, term);
    if (searchHistory.length > 10) {
      searchHistory.removeLast();
    }
    await _saveHistory();
  }

  Future<void> search(String query) async {
    isLoading = true;
    notifyListeners();
    try {
      final results = await repository.searchAll(query);
      currentResults = results;
      await saveSearchTerm(query);
    } catch (e) {
      // Handle errors gracefully
      currentResults = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
