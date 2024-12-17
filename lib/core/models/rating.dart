// lib/core/models/rating.dart

import 'package:hive/hive.dart';

part 'rating.g.dart'; // Required for Hive code generation

@HiveType(typeId: 4) // Ensure this typeId is unique across your project
class Rating extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String category; // 'movie', 'tv', 'actor'

  @HiveField(2)
  final String title;

  @HiveField(3)
  final String posterPath;

  @HiveField(4)
  double userRating;

  Rating({
    required this.id,
    required this.category,
    required this.title,
    required this.posterPath,
    required this.userRating,
  });

  factory Rating.fromMap(Map<String, dynamic> map) {
    return Rating(
      id: map['id'],
      category: map['category'],
      title: map['title'],
      posterPath: map['posterPath'],
      userRating: map['userRating'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category': category,
      'title': title,
      'posterPath': posterPath,
      'userRating': userRating,
    };
  }
}
