// lib/features/profile/pages/user_profile_screen.dart

import 'package:flutter/material.dart';
import 'package:minichallenge2/core/models/user_profile.dart';
import 'package:provider/provider.dart';
import '../../../core/providers/user_profile_provider.dart';
import 'watchlist_screen.dart';
import 'rated_list_screen.dart';
import '../../../core/providers/theme_provider.dart';


class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  void _navigateTo(BuildContext context, String routeName) {
    switch (routeName) {
      case 'watchlist':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const WatchlistScreen()),
        );
        break;
      case 'rated':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const RatingScreen()),
        );
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.themeMode == ThemeMode.dark;
    return Consumer<UserProfileProvider>(
      builder: (context, userProfileProvider, child) {
        final userProfile = userProfileProvider.userProfile;

        if (userProfile == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('User Profile')),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        return Scaffold(
          appBar: AppBar(title: const Text('User Profile')),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Display user information
                ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(userProfile.userName),
                  subtitle: Text('Country: ${userProfile.country}\nLanguage: ${userProfile.language}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      _showEditDialog(context, userProfileProvider, userProfile);
                    },
                  ),
                ),
                const SizedBox(height: 20),
                // Dark Theme Toggle
                SwitchListTile(
                  title: const Text('Dark Mode'),
                  subtitle: const Text('Enable dark theme'),
                  value: isDarkMode,
                  onChanged: (bool value) {
                    themeProvider.toggleTheme(value);
                  },
                  secondary: const Icon(Icons.dark_mode),
                ),
                const SizedBox(height: 20),
                // Subscribed Services
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Subscribed Services:',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: userProfile.subscribedServices.length,
                    itemBuilder: (context, index) {
                      final service = userProfile.subscribedServices[index];
                      return ListTile(
                        title: Text(service),
                        trailing: IconButton(
                          icon: const Icon(Icons.remove_circle, color: Colors.red),
                          onPressed: () {
                            userProfileProvider.removeSubscribedService(service);
                          },
                        ),
                      );
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _showAddServiceDialog(context, userProfileProvider);
                  },
                  child: const Text('Add Subscribed Service'),
                ),
                const SizedBox(height: 20),
                // Navigate to Watchlist
                ListTile(
                  leading: const Icon(Icons.favorite),
                  title: const Text('My Watchlist'),
                  onTap: () => _navigateTo(context, 'watchlist'),
                ),
                // Navigate to Rated List
                ListTile(
                  leading: const Icon(Icons.star),
                  title: const Text('My Ratings'),
                  onTap: () => _navigateTo(context, 'rated'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showEditDialog(BuildContext context, UserProfileProvider provider, UserProfile profile) {
    final TextEditingController userNameController = TextEditingController(text: profile.userName);
    final TextEditingController countryController = TextEditingController(text: profile.country);
    final TextEditingController languageController = TextEditingController(text: profile.language);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Profile'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: userNameController,
                  decoration: const InputDecoration(labelText: 'User Name'),
                ),
                TextField(
                  controller: countryController,
                  decoration: const InputDecoration(labelText: 'Country'),
                ),
                TextField(
                  controller: languageController,
                  decoration: const InputDecoration(labelText: 'Language'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                provider.updateUserName(userNameController.text);
                provider.updateCountry(countryController.text);
                provider.updateLanguage(languageController.text);
                Navigator.of(context).pop(); // Close dialog
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _showAddServiceDialog(BuildContext context, UserProfileProvider provider) {
    final TextEditingController serviceController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Subscribed Service'),
          content: TextField(
            controller: serviceController,
            decoration: const InputDecoration(labelText: 'Service Name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final service = serviceController.text.trim();
                if (service.isNotEmpty) {
                  provider.addSubscribedService(service);
                }
                Navigator.of(context).pop(); // Close dialog
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
