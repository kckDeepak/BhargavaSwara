import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class OrnamentationDetectionScreen extends StatefulWidget {
  const OrnamentationDetectionScreen({super.key});

  @override
  _OrnamentationDetectionScreenState createState() =>
      _OrnamentationDetectionScreenState();
}

class _OrnamentationDetectionScreenState extends State<OrnamentationDetectionScreen> {
  File? _selectedFile;
  String _analysisResult = "No file selected";

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
    );

    if (result != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
        _analysisResult = "Processing...";
      });

      // Simulating analysis (Replace this with actual ML/audio processing logic)
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          _analysisResult = "Detected: Meend, Gamak, Kan";
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ornamentation Detection"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _pickFile,
              child: Text("Upload Audio File"),
            ),
            SizedBox(height: 20),
            _selectedFile != null
                ? Text("File: ${_selectedFile!.path.split('/').last}")
                : Text("No file selected"),
            SizedBox(height: 20),
            Text(
              _analysisResult,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
