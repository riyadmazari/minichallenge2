class SearchResult {
  final int id;
  final String mediaType;
  final String name;
  final String? posterPath;

  SearchResult({
    required this.id,
    required this.mediaType,
    required this.name,
    this.posterPath,
  });

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    final mediaType = json['media_type'] ?? 'unknown';
    String name = '';
    String? posterPath;

    if (mediaType == 'movie') {
      name = json['title'] ?? '';
      posterPath = json['poster_path'];
    } else if (mediaType == 'tv') {
      name = json['name'] ?? '';
      posterPath = json['poster_path'];
    } else if (mediaType == 'person') {
      name = json['name'] ?? '';
      posterPath = json['profile_path'];
    }

    return SearchResult(
      id: json['id'] ?? 0,
      mediaType: mediaType,
      name: name,
      posterPath: posterPath,
    );
  }
}
