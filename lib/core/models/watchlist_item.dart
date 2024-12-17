// lib/core/models/watchlist_item.dart

import 'package:hive/hive.dart';

part 'watchlist_item.g.dart'; // Required for Hive code generation

@HiveType(typeId: 2)
class WatchlistItem extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final bool isMovie;

  @HiveField(2)
  final String title;

  @HiveField(3)
  final String posterPath;

  WatchlistItem({
    required this.id,
    required this.isMovie,
    required this.title,
    required this.posterPath,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'isMovie': isMovie,
      'title': title,
      'posterPath': posterPath,
    };
  }

  factory WatchlistItem.fromMap(Map<String, dynamic> map) {
    return WatchlistItem(
      id: map['id'],
      isMovie: map['isMovie'],
      title: map['title'],
      posterPath: map['posterPath'],
    );
  }
}
