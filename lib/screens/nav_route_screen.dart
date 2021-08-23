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
        title: Text(
          '${navRoute.start} to ${navRoute.destination}',
        ),
      ),
      body: ListView.builder(
        itemCount: navRoute.navSteps.length,
        itemBuilder: (context, index) {
          //TODO: I don't understand how the indexing is working correctly here, something seems off but it's still working
          final ns = navRoute.navSteps[index];

          return Card(
            child: ListTile(
              title: Text(ns.instruction),
              leading: Container(
                width: 60,
                height: 60,
                //   child: Image.network(
                //   user.imageUrl,
                //   fit: BoxFit.cover,
                // ),
                child: Center(
                  child: Text(
                    'Picture ${ns.step}',
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
