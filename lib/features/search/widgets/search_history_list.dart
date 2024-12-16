import 'package:flutter/material.dart';

class SearchHistoryList extends StatelessWidget {
  final List<String> history;
  final ValueChanged<String> onSelect;

  const SearchHistoryList({
    Key? key,
    required this.history,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (history.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('No recent searches.'),
      );
    }

    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: history.length,
        itemBuilder: (_, i) {
          final term = history[i];
          return GestureDetector(
            onTap: () => onSelect(term),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(term),
            ),
          );
        },
      ),
    );
  }
}
