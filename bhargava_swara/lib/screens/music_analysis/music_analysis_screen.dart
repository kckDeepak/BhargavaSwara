import 'package:flutter/material.dart';
import 'carnatic_hindustani_screen.dart';
import 'ornamentation_detection.dart';
import 'tempo_recognition.dart';
import 'tala_recognition.dart';
import 'raga_recognition.dart';
import 'real_time_raga_recognition.dart'; // Import the new screen

class MusicAnalysisScreen extends StatelessWidget {
  const MusicAnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Bhargava Swara")),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 2,
          padding: EdgeInsets.all(20),
          childAspectRatio: 1,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          children: [
            _buildButton(
              context,
              'Carnatic/Hindustani Identification',
              Icons.music_note,
              CarnaticHindustaniScreen(),
            ),
            _buildButton(
              context,
              'Ornamentation/Alankar Detection',
              Icons.explore,
              OrnamentationDetectionScreen(),
            ),
            _buildButton(
              context,
              'Tempo Pattern Recognition',
              Icons.audiotrack,
              TempoRecognitionScreen(),
            ),
            _buildButton(
              context,
              'Tala Recognition',
              Icons.person,
              TalaRecognitionScreen(),
            ),
            _buildButton(
              context,
              'Raga Recognition',
              Icons.person,
              RagaRecognitionScreen(),
            ),
            _buildButton(
              context,
              'Real-Time Raga Recognition',
              Icons.mic, // Icon representing real-time audio input
              RealTimeRagaRecognitionScreen(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(
      BuildContext context, String title, IconData icon, Widget screen) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.lightBlueAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        padding: EdgeInsets.all(10),
      ),
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => screen),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 50, color: Colors.white),
          SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }
}