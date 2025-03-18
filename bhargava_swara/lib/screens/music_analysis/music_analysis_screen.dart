import 'package:flutter/material.dart';
import 'carnatic_hindustani_screen.dart';
import 'ornamentation_detection.dart';
import 'repeated_pattern_recognition.dart';
import 'tala_recognition.dart';
import 'raga_recognition.dart';

class MusicAnalysisScreen extends StatelessWidget {
  const MusicAnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(title: Text("Music Analysis")),
    //   body: Padding(
    //     padding: EdgeInsets.all(16.0),
    //     child: Column(
    //       children: [
    //         _buildNavigationButton(
    //             context,
    //             "Carnatic/Hindustani Identification",
    //             CarnaticHindustaniScreen()),
    //         _buildNavigationButton(context, "Ornamentation/Alankar Detection",
    //             OrnamentationDetectionScreen()),
    //         _buildNavigationButton(context, "Tempo Pattern Recognition",
    //             RepeatedPatternRecognitionScreen()),
    //         _buildNavigationButton(
    //             context, "Tala Recognition", TalaRecognitionScreen()),
    //         _buildNavigationButton(
    //             context, "Raga Recognition", RagaRecognitionScreen()),
    //       ],
    //     ),
    //   ),
    // );
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
              RepeatedPatternRecognitionScreen(),
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
          ],
        ),
      ),
    );
  }

  Widget _buildButton(
      BuildContext context, String title, IconData icon, Widget screen) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors
            .lightBlueAccent, // Changed this line to set the button color to orange
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
