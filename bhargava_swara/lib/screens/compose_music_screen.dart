import 'package:flutter/material.dart';

class ComposeMusicScreen extends StatelessWidget {
  const ComposeMusicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Compose New Music')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<String>(
              hint: Text('Select Raga'),
              items: ['Yaman', 'Bhairav', 'Bhairavi'].map((String raga) {
                return DropdownMenuItem<String>(
                  value: raga,
                  child: Text(raga),
                );
              }).toList(),
              onChanged: (value) {
                // Handle raga selection
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add functionality to generate composition
              },
              child: Text('Generate Composition'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add functionality to play music
              },
              child: Text('Play Composition'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add functionality to save/share composition
              },
              child: Text('Save/Share'),
            ),
          ],
        ),
      ),
    );
  }
}
