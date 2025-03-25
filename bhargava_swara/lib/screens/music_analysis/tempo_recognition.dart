import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class TempoRecognitionScreen extends StatefulWidget {
  const TempoRecognitionScreen({super.key});

  @override
  _TempoRecognitionScreenState createState() => _TempoRecognitionScreenState();
}

class _TempoRecognitionScreenState extends State<TempoRecognitionScreen> {
  File? _selectedAudioFile;
  String _detectedTempo = "No analysis yet";
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

  Future<void> _analyzeAudio(File audioFile) async {
    setState(() {
      _detectedTempo = "Processing audio...";
    });

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://localhost:5004/analyze-tempo'), // Update with your backend URL
    );
    request.files.add(await http.MultipartFile.fromPath('audio', audioFile.path));

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        var result = await response.stream.bytesToString();
        setState(() {
          _detectedTempo = "Detected Tempo: $result";
        });
      } else {
        setState(() {
          _detectedTempo = "Error: Failed to analyze (Status: ${response.statusCode})";
        });
      }
    } catch (e) {
      setState(() {
        _detectedTempo = "Error: $e";
      });
    }
  }

  Future<void> _pickAudioFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
    );

    if (result != null) {
      _selectedAudioFile = File(result.files.single.path!);
      await _analyzeAudio(_selectedAudioFile!);
    }
  }

  Future<void> _startRecording() async {
    if (await Permission.microphone.request().isGranted) {
      var tempDir = await getTemporaryDirectory();
      _recordedFilePath = '${tempDir.path}/tempo_recorded.wav';
      await _audioRecorder!.startRecorder(toFile: _recordedFilePath);
      setState(() {
        _isRecording = true;
      });
    }
  }

  Future<void> _stopRecording() async {
    await _audioRecorder!.stopRecorder();
    setState(() {
      _isRecording = false;
    });

    if (_recordedFilePath != null) {
      File recordedFile = File(_recordedFilePath!);
      await _analyzeAudio(recordedFile);
    }
  }

  @override
  void dispose() {
    _audioRecorder!.closeRecorder();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tempo Recognition")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: _pickAudioFile,
              icon: Icon(Icons.file_upload),
              label: Text("Upload Audio File"),
            ),
            SizedBox(height: 10),
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
            Card(
              color: Colors.orange.shade50,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  _detectedTempo,
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