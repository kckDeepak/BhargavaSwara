import 'package:flutter/material.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

class CarnaticHindustaniScreen extends StatefulWidget {
  const CarnaticHindustaniScreen({super.key});

  @override
  _CarnaticHindustaniScreenState createState() => _CarnaticHindustaniScreenState();
}

class _CarnaticHindustaniScreenState extends State<CarnaticHindustaniScreen> {
  File? _selectedFile;
  String _result = "Upload audio to identify the music style";

  Future<void> _analyzeAudio(File audioFile) async {
    setState(() {
      _result = "Analyzing...";
    });

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://localhost:5003/analyze-style'), // Update with your backend URL
    );
    request.files.add(await http.MultipartFile.fromPath('audio', audioFile.path));

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        var result = await response.stream.bytesToString();
        setState(() {
          _result = "Identified as $result Music";
        });
      } else {
        setState(() {
          _result = "Error: Failed to analyze (Status: ${response.statusCode})";
        });
      }
    } catch (e) {
      setState(() {
        _result = "Error: $e";
      });
    }
  }

  Future<void> _pickAudioFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
    );

    if (result != null) {
      _selectedFile = File(result.files.single.path!);
      setState(() {
        _result = "Analyzing...";
      });
      await _analyzeAudio(_selectedFile!);
    }
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
                      Text(
                        "Selected File: ${_selectedFile!.path.split('/').last}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                    ],
                  )
                : Container(),
            SizedBox(height: 20),
            Text(
              _result,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}