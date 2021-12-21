import 'package:flutter/material.dart';

import '../../model/bus_route.dart';
import '../homepage.dart';
import '../indoor/nav_start_screen.dart';

class BusRoutePage extends StatefulWidget {
  const BusRoutePage({
    Key? key,
    required this.busRoute,
  }) : super(key: key);

  final BusRoute busRoute;

  @override
  _BusRoutePageState createState() => _BusRoutePageState();
}

class _BusRoutePageState extends State<BusRoutePage> {
  // List<bool> tracker = [];

  ValueNotifier<List<bool>> tracker = ValueNotifier([]);

  @override
  void initState() {
    super.initState();
    tracker.value = List<bool>.filled(widget.busRoute.busStops.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1B1C62),
        title: Text(
          '${widget.busRoute.locationStart} to ${widget.busRoute.locationEnd}',
        ),
      ),
      body: Stack(
        children: [
          ValueListenableBuilder(
              valueListenable: tracker,
              builder: (context, List<bool> trackerListen, child) {
                var count = 0;

                for (var i = 0; i < trackerListen.length; i++) {
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
            itemCount: widget.busRoute.busStops.length,
            itemBuilder: (context, index) {
              //TODO: Retrive the collection from Firestore instead

              final bs = widget.busRoute.busStops[index];

              return Card(
                child: ListTile(
                  title: Text('Checkpoint ${index + 1}'),
                  subtitle: Text(bs.stopId.toString()),
                  isThreeLine: true,
                  trailing: tracker.value[index]
                      ? const Icon(
                          Icons.done,
                          color: Colors.green,
                        )
                      : const Icon(Icons.arrow_forward_rounded),
                  // onTap: () async {
                  //   final checkboxValue = await Navigator.push(
                  //     context,
                  //     MaterialPageRoute<bool>(
                  //       builder: (context) => NavStepPage(navStep: ns),
                  //     ),
                  //   );

                  //   if (checkboxValue == true) {
                  //     setState(() {
                  //       tracker.value[index] = true;
                  //       tracker.notifyListeners();
                  //     });
                  //   }
                  // },
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NavStartPage(),
            ),
          );
        },
        label: const Text('I have arrived!'),
        icon: const Icon(Icons.thumb_up),
        backgroundColor: Colors.pink,
      ),
    );
  }
}
