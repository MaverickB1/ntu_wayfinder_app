import 'package:flutter/material.dart';

import '../model/nav_route.dart';

class zNavRoutePage extends StatelessWidget {
  const zNavRoutePage({
    Key? key,
    required this.id,
  }) : super(key: key);

  final int id;

  @override
  Widget build(BuildContext context) {
    final nr = navRoutes;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1B1C62),
        title: const Text(
          'Return to Wayfinder Page',
          // nr[id].id.toString(),
        ),
      ),
      body: ListView(
        children: [
          // Image.network(
          //   user.imageUrl,
          //   height: 300,
          //   fit: BoxFit.cover,
          // ),
          const SizedBox(height: 16),
          Text(
            '${nr[id].start} to ${nr[id].destination}',
            style: const TextStyle(fontSize: 28),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
