import 'package:flutter/material.dart';

class CarnaticPatternExplorerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Carnatic Pattern Explorer")),
      body: Center(
        child: Text(
          "Visualize Carnatic melodic structures here!",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
