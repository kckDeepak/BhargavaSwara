import 'package:flutter/material.dart';
import './screens/music_analysis/music_analysis_screen.dart';
import './screens/exploratory_tools/exploratory_tools_screen.dart';
import './screens/music_synthesis/music_synthesis_screen.dart';
import './screens/profile/profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
              'Music Analysis',
              Icons.music_note,
              MusicAnalysisScreen(),
            ),
            _buildButton(
              context,
              'Exploratory Tools',
              Icons.explore,
              ExploratoryToolsScreen(),
            ),
            _buildButton(
              context,
              'Music Synthesis',
              Icons.audiotrack,
              MusicSynthesisScreen(),
            ),
            _buildButton(
              context,
              'Profile',
              Icons.person,
              ProfileScreen(),
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
        padding: EdgeInsets.all(15),
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
