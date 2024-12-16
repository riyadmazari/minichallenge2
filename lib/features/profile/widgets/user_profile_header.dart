import 'package:flutter/material.dart';

class UserProfileHeader extends StatelessWidget {
  final String userName;

  const UserProfileHeader({Key? key, required this.userName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // You could add user avatar or additional info here if available
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 30,
            child: Icon(Icons.person, size: 30),
          ),
          const SizedBox(width: 16),
          Text(
            userName,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
    );
  }
}
