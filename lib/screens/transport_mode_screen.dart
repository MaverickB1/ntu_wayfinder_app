import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../constants.dart';

import '../data/bus/bus_route_data.dart';
import '../data/bus/bus_start_data.dart';
import '../data/car/destination_data.dart';
import '../data/indoor/nav_route_data.dart';
import '../data/indoor/nav_start_data.dart';
import 'bus/bus_start_screen.dart';
import 'car/car_screen.dart';

class TransportModePage extends StatelessWidget {
  const TransportModePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // shape: const Border(bottom: BorderSide(width: 4)),
        backgroundColor: kAppBarBackgroundColor,
        title: const Text(
          'NTU Wayfinder',
          style: kAppBarTitleTextStyle,
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              destinations.forEach((destination) {
                final collectionRef =
                    FirebaseFirestore.instance.collection('destinations');
                final docRef = collectionRef
                    .doc('destination${destination.destinationId}');

                docRef.set(destination.toJson());
              });

              navRoutes.forEach((navRoute) {
                final collectionRef =
                    FirebaseFirestore.instance.collection('navRoutes');
                final docRef = collectionRef.doc('navRoute${navRoute.routeId}');

                docRef.set(navRoute.toJson());
              });

              navStarts.forEach((navStart) {
                final collectionRef =
                    FirebaseFirestore.instance.collection('navStarts');
                final docRef =
                    collectionRef.doc('navStart${navStart.locationId}');

                docRef.set(navStart.toJson());
              });

              busRoutes.forEach((busRoute) {
                final collectionRef =
                    FirebaseFirestore.instance.collection('busRoutes');
                final docRef = collectionRef.doc('busRoute${busRoute.routeId}');

                docRef.set(busRoute.toJson());
              });

              busStarts.forEach((busStart) {
                final collectionRef =
                    FirebaseFirestore.instance.collection('busStarts');
                final docRef =
                    collectionRef.doc('busStart${busStart.locationId}');

                docRef.set(busStart.toJson());
              });
            },
            child: const Text('Sync Here'),
          ),
        ],
      ),
      backgroundColor: kScreenBackgroundColor,
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(32, 300, 32, 0),
            child: SvgPicture.asset('assets/images/transport_mode_bg.svg',
                alignment: Alignment.topCenter,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(32, 32, 32, 0),
            child: Text(
              'Transport Mode',
              style: kScreenTitleTextStyle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 128, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                  height: 48,
                  width: 128,
                  child: TextButton.icon(
                    label: const Text('Car'),
                    icon: const Icon(Icons.directions_car),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CarPage(),
                        ),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xFFD71440)),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: 48,
                  width: 128,
                  child: TextButton.icon(
                    label: const Text('Shuttle Bus'),
                    icon: const Icon(Icons.directions_bus),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BusStartPage(),
                        ),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xFFD71440)),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
