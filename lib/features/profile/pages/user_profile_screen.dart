import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../../../core/providers/user_profile_provider.dart';
import '../widgets/user_profile_header.dart';
import '../widgets/services_subscriptions.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  Future<String?> _askForInput(BuildContext context, String title, String initialValue) {
    final controller = TextEditingController(text: initialValue);
    return showDialog<String>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: TextField(controller: controller),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(context, controller.text), child: const Text('Save')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final profile = context.watch<UserProfileProvider>().profile;
    final provider = context.read<UserProfileProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('User Profile')),
      body: ListView(
        children: [
          UserProfileHeader(userName: profile.userName),
          const Divider(),
          ListTile(
            title: const Text('User Name'),
            subtitle: Text(profile.userName),
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () async {
                final newName = await _askForInput(context, 'User Name', profile.userName);
                if (newName != null && newName.isNotEmpty) {
                  provider.updateProfile(profile.copyWith(userName: newName));
                }
              },
            ),
          ),
          SwitchListTile(
            title: const Text('Dark Theme'),
            value: profile.isDarkTheme,
            onChanged: (val) {
              provider.toggleDarkTheme(val);
            },
          ),
          ListTile(
            title: const Text('Country'),
            subtitle: Text(profile.country),
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () async {
                final newCountry = await _askForInput(context, 'Country', profile.country);
                if (newCountry != null && newCountry.isNotEmpty) {
                  provider.updateProfile(profile.copyWith(country: newCountry));
                }
              },
            ),
          ),
          ListTile(
            title: const Text('Language'),
            subtitle: Text(profile.language),
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () async {
                final newLanguage = await _askForInput(context, 'Language', profile.language);
                if (newLanguage != null && newLanguage.isNotEmpty) {
                  provider.updateProfile(profile.copyWith(language: newLanguage));
                }
              },
            ),
          ),
          const Divider(),
          ServicesSubscriptions(
            subscribedServices: profile.subscribedServices,
            onUpdate: (services) {
              provider.updateProfile(profile.copyWith(subscribedServices: services));
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('My Watchlist'),
            onTap: () => context.push('/watchlist'),
          ),
          ListTile(
            title: const Text('My Rated Movies/TV Shows'),
            onTap: () => context.push('/rated'),
          ),
        ],
      ),
    );
  }
}
