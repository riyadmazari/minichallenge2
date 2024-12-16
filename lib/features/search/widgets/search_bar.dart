import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  final Function(String) onSubmit;

  const SearchBar({Key? key, required this.onSubmit}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final _controller = TextEditingController();

  void _submit() {
    final query = _controller.text.trim();
    widget.onSubmit(query);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Search for movies, TV shows, or actors...',
              ),
              onSubmitted: (_) => _submit(),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: _submit,
          ),
        ],
      ),
    );
  }
}
