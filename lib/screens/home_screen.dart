import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_app/provider/user_provider.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/homescreen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.currentUser;

    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: Center(
        child: user == null
            ? const Text("No user available")
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Name: ${user.name}",
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Email: ${user.email}",
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Phone: ${user.phone.startsWith('+2') ? user.phone.substring(2) : user.phone}",
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
      ),
    );
  }
}
