import 'package:flutter/material.dart';

import '../model/nav_route.dart';

class NavRoutePage extends StatelessWidget {
  const NavRoutePage({
    Key? key,
    required this.navRoute,
  }) : super(key: key);

  final NavRoute navRoute;

  @override
  Widget build(BuildContext context) {
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
            '${navRoute.start} to ${navRoute.destination}',
            style: const TextStyle(fontSize: 28),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
