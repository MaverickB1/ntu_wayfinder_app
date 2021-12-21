import 'package:flutter/material.dart';

import '../../model/nav_route.dart';
import '../homepage.dart';
import 'nav_step_screen.dart';

class NavRoutePage extends StatefulWidget {
  const NavRoutePage({
    Key? key,
    required this.navRoute,
  }) : super(key: key);

  final NavRoute navRoute;

  @override
  _NavRoutePageState createState() => _NavRoutePageState();
}

class _NavRoutePageState extends State<NavRoutePage> {
  // List<bool> tracker = [];

  ValueNotifier<List<bool>> tracker = ValueNotifier([]);

  @override
  void initState() {
    super.initState();
    tracker.value = List<bool>.filled(widget.navRoute.navSteps.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1B1C62),
        title: Text(
          '${widget.navRoute.locationStart} to ${widget.navRoute.locationEnd}',
        ),
      ),
      body: Stack(
        children: [
          ValueListenableBuilder(
              valueListenable: tracker,
              builder: (context, List<bool> trackerListen, child) {
                int count = 0;

                for (int i = 0; i < trackerListen.length; i++) {
                  if (trackerListen[i]) {
                    count++;
                  }
                }

                print('count: $count');

                if (count == trackerListen.length) {
                  print('Run here 2');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyHomePage(),
                    ),
                  );
                }

                return Container();
              }),
          ListView.builder(
            itemCount: widget.navRoute.navSteps.length,
            itemBuilder: (context, index) {
              //TODO: Retrive the collection from Firestore instead

              final ns = widget.navRoute.navSteps[index];
              final cpIndex = index + 1;

              return Card(
                child: ListTile(
                  leading: Image.network(ns.imageUrl),
                  title: Text(
                    'Checkpoint $cpIndex',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(ns.instruction),
                  isThreeLine: true,
                  trailing: tracker.value[index]
                      ? const Icon(
                          Icons.done,
                          color: Colors.green,
                        )
                      : const Icon(Icons.arrow_forward_rounded),
                  onTap: () async {
                    final checkboxValue = await Navigator.push(
                      context,
                      MaterialPageRoute<bool>(
                        builder: (context) =>
                            NavStepPage(navStep: ns, localIndex: cpIndex),
                      ),
                    );

                    if (checkboxValue == true) {
                      setState(() {
                        tracker.value[index] = true;
                        tracker.notifyListeners();
                      });
                    }
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
