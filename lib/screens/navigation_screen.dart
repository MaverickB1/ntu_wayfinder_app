import 'package:flutter/material.dart';

class NavigationPage extends StatelessWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return const Scaffold(
      body: Center(child: Text('Nearest Carpark')),
    );
  }
}
