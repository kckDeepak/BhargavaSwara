import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class RealTimeRagaRecognitionScreen extends StatefulWidget {
  const RealTimeRagaRecognitionScreen({super.key});

  @override
  _RealTimeRagaRecognitionScreenState createState() => _RealTimeRagaRecognitionScreenState();
}

class _RealTimeRagaRecognitionScreenState extends State<RealTimeRagaRecognitionScreen> {
  FlutterSoundRecorder? _audioRecorder;
  bool _isRecording = false;
  String _detectedDetails = "Not detecting yet";
  String? _tempFilePath;
  final int _bufferDuration = 10; // Buffer 10 seconds, matching Python

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

  Future<void> _startRealTimeAnalysis() async {
    if (await Permission.microphone.request().isGranted && !_isRecording) {
      var tempDir = await getTemporaryDirectory();
      _tempFilePath = '${tempDir.path}/real_time_raga.wav';

      await _audioRecorder!.startRecorder(
        toFile: _tempFilePath,
        codec: Codec.pcm16WAV,
        numChannels: 2, // Match Python's channels
        sampleRate: 44100, // Match Python's sample rate
      );

      setState(() {
        _isRecording = true;
        _detectedDetails = "Listening...";
      });

      _analyzeAudioStream();
    }
  }

  Future<void> _stopRealTimeAnalysis() async {
    await _audioRecorder!.stopRecorder();
    setState(() {
      _isRecording = false;
      _detectedDetails = "Not detecting yet";
    });

    if (_tempFilePath != null && File(_tempFilePath!).existsSync()) {
      File(_tempFilePath!).deleteSync();
    }
  }

  Future<void> _analyzeAudioStream() async {
    while (_isRecording) {
      await Future.delayed(Duration(seconds: _bufferDuration));
      if (_tempFilePath != null && File(_tempFilePath!).existsSync()) {
        File audioFile = File(_tempFilePath!);
        await _sendAudioForAnalysis(audioFile);

        // Restart recording for the next buffer
        await _audioRecorder!.stopRecorder();
        await _audioRecorder!.startRecorder(
          toFile: _tempFilePath,
          codec: Codec.pcm16WAV,
          numChannels: 2,
          sampleRate: 44100,
        );
      }
    }
  }

  Future<void> _sendAudioForAnalysis(File audioFile) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://localhost:5005/analyze-raga-real-time'),
    );
    request.files.add(await http.MultipartFile.fromPath('audio', audioFile.path));

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        var result = await response.stream.bytesToString();
        setState(() {
          _detectedDetails = result.isEmpty ? "No Details Detected" : result;
        });
      } else {
        setState(() {
          _detectedDetails = "Error: Failed to analyze (Status: ${response.statusCode})";
        });
      }
    } catch (e) {
      setState(() {
        _detectedDetails = "Error: $e";
      });
    }
  }

  @override
  void dispose() {
    if (_isRecording) {
      _audioRecorder!.stopRecorder();
    }
    _audioRecorder!.closeRecorder();
    if (_tempFilePath != null && File(_tempFilePath!).existsSync()) {
      File(_tempFilePath!).deleteSync();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Real-Time Raga Recognition")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _isRecording
                ? ElevatedButton.icon(
                    onPressed: _stopRealTimeAnalysis,
                    icon: Icon(Icons.stop),
                    label: Text("Stop Listening"),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  )
                : ElevatedButton.icon(
                    onPressed: _startRealTimeAnalysis,
                    icon: Icon(Icons.mic),
                    label: Text("Start Listening"),
                  ),
            SizedBox(height: 20),
            Expanded(
              child: Card(
                color: Colors.green.shade50,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Text(
                      _detectedDetails,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}