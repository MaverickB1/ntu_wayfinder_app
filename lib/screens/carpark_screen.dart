import 'package:flutter/material.dart';

class CarparkPage extends StatelessWidget {
  const CarparkPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return const Scaffold(
      body: Center(child: Text('Nearest Carpark')),
    );
  }
}
