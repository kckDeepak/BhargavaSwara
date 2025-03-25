import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class OrnamentationDetectionScreen extends StatefulWidget {
  const OrnamentationDetectionScreen({super.key});

  @override
  _OrnamentationDetectionScreenState createState() =>
      _OrnamentationDetectionScreenState();
}

class _OrnamentationDetectionScreenState
    extends State<OrnamentationDetectionScreen> {
  File? _selectedFile;
  String _analysisResult = "No file selected";

  Future<void> _analyzeAudio(File audioFile) async {
    setState(() {
      _analysisResult = "Processing...";
    });

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://localhost:5002/analyze-ornamentation'), // Update with your backend URL
    );
    request.files.add(await http.MultipartFile.fromPath('audio', audioFile.path));

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        var result = await response.stream.bytesToString();
        setState(() {
          _analysisResult = "Detected: $result";
        });
      } else {
        setState(() {
          _analysisResult =
              "Error: Failed to analyze (Status: ${response.statusCode})";
        });
      }
    } catch (e) {
      setState(() {
        _analysisResult = "Error: $e";
      });
    }
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
    );

    if (result != null) {
      _selectedFile = File(result.files.single.path!);
      setState(() {
        _analysisResult = "Processing...";
      });
      await _analyzeAudio(_selectedFile!);
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