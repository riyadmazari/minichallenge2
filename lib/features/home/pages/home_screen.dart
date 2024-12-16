import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/providers/trending_provider.dart';
import '../widgets/trending_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    // Schedule the loadTrending() after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TrendingProvider>().loadTrending();
      setState(() {
        _initialized = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final trendingProvider = context.watch<TrendingProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Trending'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => context.push('/search'),
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => context.push('/profile'),
          ),
        ],
      ),
      body: !_initialized || trendingProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Trending Movies',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    TrendingList(
                      items: trendingProvider.trendingMovies,
                      isMovie: true,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Trending TV Shows',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    TrendingList(
                      items: trendingProvider.trendingTVShows,
                      isMovie: false,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
