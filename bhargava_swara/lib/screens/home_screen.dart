import 'package:flutter/material.dart';
import 'raga_recognition_screen.dart';
import 'compose_music_screen.dart';
import 'learn_ragas_screen.dart';
import 'collaborate_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bhargava Swara')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildNavButton(context, 'Real-Time Raga Recognition', RagaRecognitionScreen()),
            _buildNavButton(context, 'Compose New Music', ComposeMusicScreen()),
            _buildNavButton(context, 'Learn Ragas', LearnRagasScreen()),
            _buildNavButton(context, 'Collaborate with Others', CollaborateScreen()),
            _buildNavButton(context, 'Profile & History', ProfileScreen()),
          ],
        ),
      ),
    );
  }

  Widget _buildNavButton(BuildContext context, String title, Widget screen) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () => Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => screen),
        ),
        child: Text(title),
      ),
    );
  }
}
