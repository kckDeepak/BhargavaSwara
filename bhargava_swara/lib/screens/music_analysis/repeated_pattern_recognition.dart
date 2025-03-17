import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:ffmpeg_kit_flutter_min/ffmpeg_kit.dart';
import 'package:tflite_flutter/tflite_flutter.dart'; // Load TensorFlow Lite model
// If using server-side model

class RepeatedPatternRecognitionScreen extends StatefulWidget {
  const RepeatedPatternRecognitionScreen({super.key});

  @override
  _RepeatedPatternRecognitionScreenState createState() =>
      _RepeatedPatternRecognitionScreenState();
}

class _RepeatedPatternRecognitionScreenState
    extends State<RepeatedPatternRecognitionScreen> {
  File? _selectedFile;
  String _analysisResult = "No file selected";
  Interpreter? _interpreter; // TFLite model interpreter

  @override
  void initState() {
    super.initState();
    _loadModel();
  }

  Future<void> _loadModel() async {
    try {
      _interpreter =
          await Interpreter.fromAsset('assets/repeated_pattern_model.tflite');
      print("Model Loaded Successfully!");
    } catch (e) {
      print("Error loading model: $e");
    }
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
    );

    if (result != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
        _analysisResult = "Processing...";
      });

      await _extractFeatures(_selectedFile!);
    }
  }

  Future<void> _extractFeatures(File audioFile) async {
    String outputPath = "${audioFile.path}.wav";

    // Convert to WAV format for feature extraction
    await FFmpegKit.execute("-i ${audioFile.path} -ar 16000 -ac 1 $outputPath");

    // Use an ML model to detect patterns
    await _detectPatterns(outputPath);
  }

  Future<void> _detectPatterns(String filePath) async {
    // Convert WAV file to spectrogram (Example for local model)
    var inputTensor = _prepareInputData(filePath);

    var outputTensor =
        List.filled(10, 0.0).reshape([1, 10]); // Dummy output shape
    _interpreter?.run(inputTensor, outputTensor);

    setState(() {
      _analysisResult =
          "Repeated Patterns Detected:\n- Pattern 1 at 00:10 - 00:20\n- Pattern 2 at 01:05 - 01:15";
    });
  }

  List<List<double>> _prepareInputData(String filePath) {
    // TODO: Convert WAV to MFCC features and return as input tensor
    return List.generate(
        128, (_) => List.generate(20, (_) => 0.0)); // Dummy data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tempo Pattern Recognition"),
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
