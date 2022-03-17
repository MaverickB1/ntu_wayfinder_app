import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../model/bus_route.dart';
import '../../services/map_util.dart';
import '../indoor/nav_start_screen.dart';
// import 'package:ntu_wayfinder_app/constants.dart';
import 'bus_stop_screen.dart';
// import 'package:ntu_wayfinder_app/services/map_util.dart';

// import '../../model/bus_route.dart';
// import '../home_screen.dart';
// import '../indoor/nav_start_screen.dart';

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
  int durationCounter = 0;
  // widget.busRoute.busStops.forEach((e) => e.travelDuration += )

  @override
  void initState() {
    super.initState();
    tracker.value = List<bool>.filled(widget.busRoute.busStops.length, false);

    widget.busRoute.busStops.forEach((e) {
      durationCounter += e.travelDuration;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kAppBarBackgroundColor,
        title: Text(
          '${widget.busRoute.locationStart} to ${widget.busRoute.locationEnd}',
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
          Padding(
            padding: const EdgeInsets.all(4),
            child: Row(
              children: [
                Container(
                  height: 80,
                  width: 120,
                  decoration: BoxDecoration(
                    color: widget.busRoute.serviceIsRed
                        ? Colors.redAccent
                        : Colors.blueAccent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                        widget.busRoute.serviceIsRed ? 'Red Line' : 'Blue Line',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Column(
                    children: [
                      Chip(
                        avatar: const Icon(Icons.directions_bus,
                            color: Colors.white),
                        label: Container(
                          width: 84,
                          height: 24,
                          child: Center(
                            child: widget.busRoute.serviceIsRed
                                ? Text(
                                    'Stops: ${widget.busRoute.busStops.length - 2}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  )
                                : Text(
                                    'Stops: ${widget.busRoute.busStops.length - 3}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                        backgroundColor: widget.busRoute.serviceIsRed
                            ? Colors.lightBlueAccent
                            : Colors.deepOrangeAccent,
                      ),
                      Chip(
                        avatar:
                            const Icon(Icons.access_time, color: Colors.white),
                        label: Container(
                          width: 84,
                          height: 24,
                          child: Center(
                            child: Text(
                              '$durationCounter minutes',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        backgroundColor: widget.busRoute.serviceIsRed
                            ? Colors.lightBlueAccent
                            : Colors.deepOrangeAccent,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: ConstrainedBox(
                    constraints:
                        const BoxConstraints.tightFor(width: 140, height: 80),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        MapUtil.openMap(widget.busRoute.mapLaunchUrl);
                      },
                      icon: const Icon(
                        Icons.arrow_circle_up,
                        color: Colors.black,
                      ),
                      label: Expanded(
                        child: Text(
                          'Directions to\n${widget.busRoute.locationStart}\nbus stop',
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.lightGreenAccent),
                    ),
                  ),
                ),
              ],
            ),
          ),
          ClipRRect(
            child: Image.asset(widget.busRoute.busStops[0].stopImage),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.busRoute.busStops.length,
              itemBuilder: (context, index) {
                final bs = widget.busRoute.busStops[index];
                final checkpointNumber = index + 1;

                return Card(
                  child: ListTile(
                    tileColor: bs.isAlight
                        ? Colors.redAccent[400]
                        : bs.isStop
                            ? Colors.white
                            : Colors.lime[100],
                    leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(bs.stopImage)),
                    title: bs.isAlight
                        ? Text(
                            'Checkpoint $checkpointNumber (Alight Here!)',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : bs.isStop
                            ? Text(
                                'Checkpoint $checkpointNumber',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : const Text(
                                'Transit',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                    subtitle: Text(bs.stopName),
                    isThreeLine: true,
                    trailing: bs.isStop
                        ? null
                        : tracker.value[index]
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
                            finalStep: checkpointNumber >=
                                    widget.busRoute.busStops.length
                                ? true
                                : false,
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
    );
  }
}
