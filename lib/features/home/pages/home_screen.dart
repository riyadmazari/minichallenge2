// lib/features/home/pages/home_screen.dart

import 'package:flutter/material.dart';
import 'package:minichallenge2/features/profile/pages/user_profile_screen.dart';
import 'package:minichallenge2/features/search/pages/search_sreen.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<TrendingProvider>().loadTrending();
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
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchScreen(), // Replace with your actual SearchScreen
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UserProfileScreen(), // Replace with your actual ProfileScreen
                ),
              );
            },
          ),
        ],
      ),
      body: !_initialized || trendingProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : trendingProvider.errorMessage.isNotEmpty
              ? Center(child: Text(trendingProvider.errorMessage))
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
                        trendingProvider.trendingMovies.isNotEmpty
                            ? TrendingList(
                                items: trendingProvider.trendingMovies,
                                isMovie: true,
                              )
                            : const Text('No items available.'),
                        const SizedBox(height: 24),
                        Text(
                          'Trending TV Shows',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        trendingProvider.trendingTVShows.isNotEmpty
                            ? TrendingList(
                                items: trendingProvider.trendingTVShows,
                                isMovie: false,
                              )
                            : const Text('No items available.'),
                      ],
                    ),
                  ),
                ),
    );
  }
}
