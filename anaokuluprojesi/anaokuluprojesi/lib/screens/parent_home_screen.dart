import 'package:flutter/material.dart';

class ParentHomeScreen extends StatelessWidget {
  const ParentHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Veli Paneli'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Çıkış Yap',
            onPressed: () {
              // Navigate back to Login Screen
              Navigator.of(context).pushReplacementNamed('/login');
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.child_care), // Example icon
            title: const Text('Çocuğumun Özeti'),
            subtitle: const Text('Günlük rapor, yoklama vb.'),
            onTap: () {
              // Navigate to Parent Daily Report Screen
              Navigator.of(context).pushNamed('/parent_daily_report');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.campaign_outlined), // Announcements icon
            title: const Text('Duyurular'),
            onTap: () {
              // Navigate to Announcements Screen
              Navigator.of(context).pushNamed('/announcements');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.restaurant_menu_outlined), // Menu icon
            title: const Text('Yemek Menüsü'),
            onTap: () {
              // Navigate to Menu Screen
              Navigator.of(context).pushNamed('/menu');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.message_outlined), // Message icon
            title: const Text('Mesajlaşma'),
            onTap: () {
              // Navigate to Conversations Screen
              Navigator.of(context).pushNamed('/conversations');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.calendar_today_outlined), // Calendar icon
            title: const Text('Etkinlik Takvimi'),
            onTap: () {
              // Navigate to Calendar Screen
              Navigator.of(context).pushNamed('/calendar');
            },
          ),
          // Add more ListTiles for other features (Gallery, Messages, Menu etc.)
        ],
      ),
      // TODO: Add BottomNavigationBar or Drawer for parent features
    );
  }
}
