import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile & History')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/profile_pic.png'), // Replace with actual image
                  ),
                  SizedBox(height: 10),
                  Text(
                    'John Doe', // Replace with dynamic user name
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Music Enthusiast & Raga Explorer', // Replace with dynamic bio
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text('Achievements', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ListTile(
              leading: Icon(Icons.star, color: Colors.amber),
              title: Text('Learned 10 Ragas'),
            ),
            ListTile(
              leading: Icon(Icons.music_note, color: Colors.blue),
              title: Text('Composed 5 Original Pieces'),
            ),
            SizedBox(height: 20),
            Text('History', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(Icons.library_music),
                    title: Text('Recently Analyzed: Raga Yaman'),
                  ),
                  ListTile(
                    leading: Icon(Icons.audiotrack),
                    title: Text('Saved Composition: Evening Bliss'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
