import 'package:flutter/material.dart';

class AchievementsScreen extends StatelessWidget {
  final List<String> achievements = [
    "🎖 First Raga Identified",
    "🎼 10 Successful Analyses",
    "🔍 Identified 5 Ornamentations",
    "🎶 Created First Composition",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Achievements & Learning Progress")),
      body: ListView.builder(
        itemCount: achievements.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(achievements[index]),
            leading: Icon(Icons.emoji_events, color: Colors.amber),
          );
        },
      ),
    );
  }
}
