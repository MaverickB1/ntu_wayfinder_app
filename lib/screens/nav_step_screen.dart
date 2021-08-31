import 'package:flutter/material.dart';
import '../model/nav_step.dart';

class NavStepPage extends StatefulWidget {
  final NavStep navStep;

  // ignore: sort_constructors_first
  const NavStepPage({Key? key, required this.navStep}) : super(key: key);

  @override
  _NavStepPageState createState() => _NavStepPageState();
}

class _NavStepPageState extends State<NavStepPage> {
  bool checkBoxValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1B1C62),
        title: Text(
          'Checkpoint ${widget.navStep.step}',
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(32),
            child: const Text('Picture goes here'),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(widget.navStep.instruction),
            ),
          ),
          Checkbox(
            value: checkBoxValue,
            onChanged: (value) {
              setState(() {
                checkBoxValue = value!;
              });
            },
          )
        ],
      ),
    );
  }
}
