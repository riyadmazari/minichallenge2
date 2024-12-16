class RatedItem {
  final int id;
  final bool isMovie;
  final String title;
  final String posterPath;
  final double userRating;

  RatedItem({
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

  factory RatedItem.fromMap(Map<String, dynamic> map) {
    return RatedItem(
      id: map['id'],
      isMovie: map['isMovie'],
      title: map['title'],
      posterPath: map['posterPath'],
      userRating: (map['userRating'] as num).toDouble(),
    );
  }
}
