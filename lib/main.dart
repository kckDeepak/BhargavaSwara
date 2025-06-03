import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(AudioAnalyzerApp());
}

class AudioAnalyzerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Audio Analyzer',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.blueAccent,
        scaffoldBackgroundColor: Colors.black,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
      home: AudioAnalyzerPage(),
    );
  }
}

class AudioAnalyzerPage extends StatefulWidget {
  @override
  _AudioAnalyzerPageState createState() => _AudioAnalyzerPageState();
}

class _AudioAnalyzerPageState extends State<AudioAnalyzerPage> {
  Uint8List? _selectedFile;
  String? _fileName;
  String _output = '';

  final List<Map<String, String>> _analysisOptions = [
    {'label': 'Raga', 'endpoint': '/analyze_raga'},
    {'label': 'Tala', 'endpoint': '/analyze_tala'},
    {'label': 'Tempo', 'endpoint': '/analyze_tempo'},
    {'label': 'Tradition', 'endpoint': '/analyze_tradition'},
    {'label': 'Ornaments', 'endpoint': '/analyze_ornaments'},
    {'label': 'Full Analysis', 'endpoint': '/analyze_music_full'},
  ];

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['wav', 'mp3', 'm4a'],
    );

    if (result != null && result.files.single.bytes != null) {
      setState(() {
        _selectedFile = result.files.single.bytes;
        _fileName = result.files.single.name;
      });
    }
  }

  Future<void> _analyze(String endpoint) async {
    if (_selectedFile == null || _fileName == null) {
      setState(() => _output = 'Please upload an audio file first.');
      return;
    }

    setState(() => _output = 'Analyzing...');

    try {
      var response = await _uploadFile(_selectedFile!, _fileName!, endpoint);
      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final decodedResponse = jsonDecode(responseBody);
        setState(() => _output = decodedResponse['result'] ?? 'No result found.');
      } else {
        setState(() => _output = 'Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      setState(() => _output = 'Error: $e');
    }
  }

  Future<http.StreamedResponse> _uploadFile(Uint8List fileBytes, String fileName, String endpoint) async {
    String baseUrl = dotenv.env['API_URL'] ?? 'http://127.0.0.1:5000';
    var uri = Uri.parse('$baseUrl$endpoint');
    var request = http.MultipartRequest('POST', uri)
      ..files.add(http.MultipartFile.fromBytes('audio', fileBytes, filename: fileName));
    return await request.send();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Audio Analyzer')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: _pickFile,
              child: Text(_fileName ?? 'Pick an Audio File'),
            ),
            SizedBox(height: 20),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: _analysisOptions.map((option) {
                return ElevatedButton(
                  onPressed: () => _analyze(option['endpoint']!),
                  child: Text(option['label']!),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blueGrey[900],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SingleChildScrollView(
                  child: Text(
                    _output,
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                    textAlign: TextAlign.center,
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
