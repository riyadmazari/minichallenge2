// lib/core/models/cast_member.dart

import 'package:hive/hive.dart';

part 'actor.g.dart'; // Required for Hive code generation

class Actor {
  final int id;
  final String name;
  final String? profilePath;
  final String? birthday;
  final String? deathday;
  final List<Map<String, dynamic>> knownCredits;

  Actor({
    required this.id,
    required this.name,
    this.profilePath,
    this.birthday,
    this.deathday,
    required this.knownCredits,
  });

  int get age {
    if (birthday == null || birthday!.isEmpty) return 0;
    final birth = DateTime.tryParse(birthday!);
    if (birth == null) return 0;
    final now = DateTime.now();
    int age = now.year - birth.year;
    if (now.month < birth.month || (now.month == birth.month && now.day < birth.day)) {
      age--;
    }
    return age;
  }

  factory Actor.fromFullJson(Map<String, dynamic> json) {
    // Parse known credits from movie_credits and tv_credits
    List<Map<String, dynamic>> credits = [];

    if (json['movie_credits'] != null && json['movie_credits']['cast'] is List) {
      final movieCast = json['movie_credits']['cast'] as List;
      for (var c in movieCast) {
        credits.add({
          'title': c['title'],
          'poster_path': c['poster_path'],
          'media_type': 'movie'
        });
      }
    }

    if (json['tv_credits'] != null && json['tv_credits']['cast'] is List) {
      final tvCast = json['tv_credits']['cast'] as List;
      for (var c in tvCast) {
        credits.add({
          'name': c['name'],
          'poster_path': c['poster_path'],
          'media_type': 'tv'
        });
      }
    }

    // You may want to sort credits by popularity or release date if needed. Here we leave as is.

    return Actor(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      profilePath: json['profile_path'],
      birthday: json['birthday'],
      deathday: json['deathday'],
      knownCredits: credits,
    );
  }
}

// A helper class for cast members to avoid code duplication:
@HiveType(typeId: 3)
class CastMember extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String? profilePath;

  @HiveField(2)
  final String? character;

  CastMember({
    required this.name,
    this.profilePath,
    this.character,
  });

  factory CastMember.fromJson(Map<String, dynamic> json) {
    return CastMember(
      name: json['name'] ?? '',
      profilePath: json['profile_path'],
      character: json['character'],
    );
  }
}
