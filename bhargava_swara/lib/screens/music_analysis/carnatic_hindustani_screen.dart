import 'package:flutter/material.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';

class CarnaticHindustaniScreen extends StatefulWidget {
  const CarnaticHindustaniScreen({super.key});

  @override
  _CarnaticHindustaniScreenState createState() => _CarnaticHindustaniScreenState();
}

class _CarnaticHindustaniScreenState extends State<CarnaticHindustaniScreen> {
  File? _selectedFile;
  String _result = "Upload or record audio to identify the music style";

  Future<void> _pickAudioFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
    );

    if (result != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
        _result = "Analyzing...";
      });

      // Simulate analysis delay
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          _result = _analyzeAudio(); // Mock analysis function
        });
      });
    }
  }

  String _analyzeAudio() {
    // Mock function: Replace with ML model integration later
    return (DateTime.now().second % 2 == 0)
        ? "Identified as Carnatic Music 🎻"
        : "Identified as Hindustani Music 🎼";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Carnatic vs Hindustani')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _pickAudioFile,
              icon: Icon(Icons.upload_file),
              label: Text("Upload Audio File"),
            ),
            SizedBox(height: 20),
            _selectedFile != null
                ? Column(
                    children: [
                      Text("Selected File: ${_selectedFile!.path.split('/').last}", style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                    ],
                  )
                : Container(),
            SizedBox(height: 20),
            Text(
              _result,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
