import 'package:flutter/material.dart';

class RagaRecognitionScreen extends StatefulWidget {
  const RagaRecognitionScreen({super.key});

  @override
  _RagaRecognitionScreenState createState() => _RagaRecognitionScreenState();
}

class _RagaRecognitionScreenState extends State<RagaRecognitionScreen> {
  bool isRecording = false;
  String identifiedRaga = 'None';
  double pitchAccuracy = 0.0;

  void toggleRecording() {
    setState(() {
      isRecording = !isRecording;
      if (isRecording) {
        // Simulate raga recognition
        Future.delayed(Duration(seconds: 3), () {
          setState(() {
            identifiedRaga = 'Yaman';
            pitchAccuracy = 92.5;
            isRecording = false;
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Real-Time Raga Recognition')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(child: Text('Waveform Visualizer (Placeholder)')),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: toggleRecording,
              style: ElevatedButton.styleFrom(
                backgroundColor: isRecording ? Colors.red : Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: Text(isRecording ? 'Stop Recording' : 'Start Recording'),
            ),
            SizedBox(height: 20),
            Card(
              margin: EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Identified Raga: $identifiedRaga',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 5),
                    Text('Pitch Accuracy: $pitchAccuracy%'),
                    SizedBox(height: 5),
                    Text('Aroha: S R G M P D N S'),
                    Text('Avaroha: S N D P M G R S'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
