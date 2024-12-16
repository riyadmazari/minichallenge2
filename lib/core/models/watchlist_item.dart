class WatchlistItem {
  final int id;
  final bool isMovie;
  final String title;
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
