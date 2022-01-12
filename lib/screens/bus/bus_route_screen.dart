import 'package:flutter/material.dart';
import 'package:ntu_wayfinder_app/constants.dart';
import 'package:ntu_wayfinder_app/screens/bus/bus_stop_screen.dart';
import 'package:ntu_wayfinder_app/services/map_util.dart';

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
        backgroundColor: kAppBarBackgroundColor,
        title: Text(
          '${widget.busRoute.service} Line from ${widget.busRoute.locationStart} to ${widget.busRoute.locationEnd}',
          style: kAppBarTitleTextStyle,
        ),
      ),
      body: Column(
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
                      builder: (context) => NavStartPage(),
                    ),
                  );
                }

                return Container();
              }),
          Image.asset(widget.busRoute.busStops[0].stopImage),
          Expanded(
            child: ListView.builder(
              itemCount: widget.busRoute.busStops.length,
              itemBuilder: (context, index) {
                final bs = widget.busRoute.busStops[index];
                final checkpointNumber = index + 1;

                return Card(
                  child: ListTile(
                    leading: Image.asset(bs.stopImage),
                    title: Text(
                      'Checkpoint $checkpointNumber',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(bs.stopName),
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
                          builder: (context) => BusStopPage(
                            busStop: bs,
                            localIndex: checkpointNumber,
                          ),
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
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => const NavStartPage(),
          //   ),
          // );
          MapUtil.openMap(widget.busRoute.mapLaunchUrl);
        },
        label: Text('Get me to ${widget.busRoute.locationStart} bus stop'),
        icon: const Icon(Icons.bus_alert),
        backgroundColor: kButtonBackgroundColor,
      ),
    );
  }
}
