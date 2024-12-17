// lib/features/search/pages/search_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/providers/search_provider.dart';
import '../widgets/search_bar.dart' as custom;
import '../widgets/search_history_list.dart';
import '../widgets/search_results_list.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    final searchProvider = context.watch<SearchProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Column(
        children: [
          custom.SearchBar(
            onSubmit: (query) {
              if (query.isNotEmpty) {
                context.read<SearchProvider>().search(query);
              }
            },
          ),
          const SizedBox(height: 8),
          Text(
            'Recent Searches',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          SearchHistoryList(
            history: searchProvider.searchHistory,
            onSelect: (term) {
              context.read<SearchProvider>().search(term);
            },
          ),
          const SizedBox(height: 8),
          Expanded(
            child: searchProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : searchProvider.errorMessage.isNotEmpty
                    ? Center(child: Text(searchProvider.errorMessage))
                    : searchProvider.currentResults.isNotEmpty
                        ? SearchResultsList(
                            results: searchProvider.currentResults,
                          )
                        : const Center(child: Text('No results')),
          ),
        ],
      ),
    );
  }
}
