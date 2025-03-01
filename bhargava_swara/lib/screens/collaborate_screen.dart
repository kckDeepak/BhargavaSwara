import 'package:flutter/material.dart';

class CollaborateScreen extends StatelessWidget {
  const CollaborateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Collaborate with Others')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Add functionality to create a new session
              },
              child: Text('Create a Room'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add functionality to join an existing session
              },
              child: Text('Join a Room'),
            ),
          ],
        ),
      ),
    );
  }
}
