import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/api/tmdb_repository.dart';
import '../../../core/models/movie.dart';
import '../widgets/cast_list.dart';
import '../widgets/info_section.dart';

class MovieDetailScreen extends StatefulWidget {
  final int movieId;
  const MovieDetailScreen({Key? key, required this.movieId}) : super(key: key);

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  Movie? movie;
  bool loading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadMovie();
  }

  Future<void> _loadMovie() async {
    final repo = context.read<TMDBRepository>();
    try {
      final result = await repo.getMovieDetails(widget.movieId);
      setState(() {
        movie = result;
        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
        errorMessage = 'Failed to load movie details.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (errorMessage.isNotEmpty || movie == null) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(child: Text(errorMessage.isEmpty ? 'No movie found.' : errorMessage)),
      );
    }

    final posterUrl = 'https://image.tmdb.org/t/p/w500${movie!.posterPath}';

    return Scaffold(
      appBar: AppBar(
        title: Text(movie!.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            posterUrl.isNotEmpty
                ? Image.network(posterUrl, fit: BoxFit.cover)
                : Container(
                    height: 200,
                    color: Colors.grey.shade300,
                    child: const Center(child: Icon(Icons.image)),
                  ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: InfoSection(
                title: movie!.title,
                overview: movie!.overview,
                releaseDate: movie!.releaseDate,
                rating: movie!.rating,
                genres: movie!.genres, // Assuming parsed genres
                runtime: movie!.runtime, // Assuming parsed runtime
                director: movie!.director, // Assuming `director` field from full details
                pegi: movie!.pegiRating, // Assuming `pegiRating` field from full details
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CastList(cast: movie!.cast.take(3).toList()), // Take at least 3 cast members
            ),
          ],
        ),
      ),
    );
  }
}
