import 'package:flutter/material.dart';

import 'indoor/nav_start_screen.dart';
import 'transport_mode_screen.dart';

class MyHomePage extends StatefulWidget {
  final int currentIndex;

  MyHomePage({this.currentIndex = 0});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  final screens = [
    const TransportModePage(),
    const NavStartPage(),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.blueAccent,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.commute),
            label: 'Transport Mode',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions),
            label: 'Indoor Navigation',
          ),
        ],
      ),
    );
  }
}
