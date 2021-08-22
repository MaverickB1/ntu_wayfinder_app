import 'package:flutter/material.dart';

import '../model/nav_route.dart';

class NavRoutePage extends StatelessWidget {
  const NavRoutePage({
    Key? key,
    required this.id,
  }) : super(key: key);

  final int id;

  @override
  Widget build(BuildContext context) {
    final nr = navRoutes;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          nr[id].id.toString(),
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
            nr[id].start,
            style: const TextStyle(fontSize: 28),
            textAlign: TextAlign.center,
          ),
          Text(
            nr[id].destination,
            style: const TextStyle(fontSize: 28),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
