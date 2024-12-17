// lib/core/models/rating.dart

import 'package:hive/hive.dart';

part 'rating.g.dart'; // Required for Hive code generation

@HiveType(typeId: 4) // Assign a unique typeId (ensure it's not used by other models)
class Rating extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final bool isMovie;

  @HiveField(2)
  final String title;

  @HiveField(3)
  final String posterPath;

  @HiveField(4)
  final double userRating;

  Rating({
    required this.id,
    required this.isMovie,
    required this.title,
    required this.posterPath,
    required this.userRating,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'isMovie': isMovie,
      'title': title,
      'posterPath': posterPath,
      'userRating': userRating,
    };
  }

  factory Rating.fromMap(Map<String, dynamic> map) {
    return Rating(
      id: map['id'],
      isMovie: map['isMovie'],
      title: map['title'],
      posterPath: map['posterPath'],
      userRating: (map['userRating'] as num).toDouble(),
    );
  }
}
