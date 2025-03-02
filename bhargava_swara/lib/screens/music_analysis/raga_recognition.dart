import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

class RagaRecognitionScreen extends StatefulWidget {
  @override
  _RagaRecognitionScreenState createState() => _RagaRecognitionScreenState();
}

class _RagaRecognitionScreenState extends State<RagaRecognitionScreen> {
  File? _selectedAudioFile;
  String _detectedRaga = "No analysis yet";
  FlutterSoundRecorder? _audioRecorder;
  bool _isRecording = false;
  String? _recordedFilePath;

  @override
  void initState() {
    super.initState();
    _audioRecorder = FlutterSoundRecorder();
    _initRecorder();
  }

  Future<void> _initRecorder() async {
    await _audioRecorder!.openRecorder();
    await Permission.microphone.request();
  }

  Future<void> _pickAudioFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
    );

    if (result != null) {
      setState(() {
        _selectedAudioFile = File(result.files.single.path!);
        _detectedRaga = "Processing audio...";
      });

      // Placeholder for ML Model Processing
      Future.delayed(Duration(seconds: 3), () {
        setState(() {
          _detectedRaga = "Detected Raga: Yaman (Placeholder)";
        });
      });
    }
  }

  Future<void> _startRecording() async {
    if (await Permission.microphone.request().isGranted) {
      setState(() => _isRecording = true);
      _recordedFilePath = await _audioRecorder!.startRecorder(
        toFile: 'raga_recorded.wav',
      );
    }
  }

  Future<void> _stopRecording() async {
    await _audioRecorder!.stopRecorder();
    setState(() {
      _isRecording = false;
      _detectedRaga = "Processing recording...";
    });

    // Placeholder for ML Model Processing
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        _detectedRaga = "Detected Raga: Bhairavi (Placeholder)";
      });
    });
  }

  @override
  void dispose() {
    _audioRecorder!.closeRecorder();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Raga Recognition")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // File Upload Button
            ElevatedButton.icon(
              onPressed: _pickAudioFile,
              icon: Icon(Icons.file_upload),
              label: Text("Upload Audio File"),
            ),
            SizedBox(height: 10),

            // Recording Controls
            _isRecording
                ? ElevatedButton.icon(
                    onPressed: _stopRecording,
                    icon: Icon(Icons.stop),
                    label: Text("Stop Recording"),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  )
                : ElevatedButton.icon(
                    onPressed: _startRecording,
                    icon: Icon(Icons.mic),
                    label: Text("Start Recording"),
                  ),
            SizedBox(height: 20),

            // Detected Raga Output
            Card(
              color: Colors.green.shade50,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  _detectedRaga,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
