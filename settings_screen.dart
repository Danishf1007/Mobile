// lib/screens/settings_screen.dart
import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart'; // Import the drawer

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      drawer: const AppDrawer(), // Add the drawer
      body: const Center(
        child: Text(
          'Settings Page Content Here',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}