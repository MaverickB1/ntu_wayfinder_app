import 'package:flutter/material.dart';

import '../model/nav_route.dart';
import 'nav_step_screen.dart';

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
          final ns = navRoute.navSteps[index];
          //TODO: Retrive the collection from Firestore instead

          return Card(
            child: ListTile(
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
              title: Text('Checkpoint ${ns.step}'),
              subtitle: Text(ns.instruction),
              isThreeLine: true,
              trailing: const Icon(Icons.arrow_forward_rounded),
              onTap: () {
                Navigator.of(context).push<MaterialPageRoute>(
                  MaterialPageRoute(
                    builder: (context) => NavStepPage(navStep: ns),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
