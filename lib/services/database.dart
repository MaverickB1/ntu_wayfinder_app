import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ntu_wayfinder_app/model/bus_route.dart';
import 'package:ntu_wayfinder_app/model/bus_start.dart';

import '../model/destination.dart';
import '../model/nav_route.dart';
import '../model/nav_start.dart';

class Database {
  // final _firestore = FirebaseFirestore.instance;

  static Future<List<Destination>> getDestinationList() async {
    final destinationsCoRef =
        FirebaseFirestore.instance.collection('destinations');
    //dot operator takes precedence over await method
    final destinationsQSnapshot = await destinationsCoRef.get();
    final destinationsQDocSnapshot = destinationsQSnapshot.docs;
    final destinations = List<Destination>.empty(growable: true);

    destinationsQDocSnapshot.forEach((doc) {
      final destination = Destination.fromJson(doc.data());
      destinations.add(destination);
    });

    return destinations;
  }

  static Future<List<NavRoute>> getNavRouteList(
      {required NavStart navStart}) async {
    final navRoutesCoRef = FirebaseFirestore.instance.collection('navRoutes');
    //dot operator takes precedence over await method
    final navRoutesQSnapshot = await navRoutesCoRef.get();
    final navRoutesQDocSnapshot = navRoutesQSnapshot.docs;
    final navRoutes = List<NavRoute>.empty(growable: true);

    navRoutesQDocSnapshot.forEach((doc) {
      print('locationName: ${navStart.locationName}');

      final navRoute = NavRoute.fromJson(doc.data());

      print('locationStart: ${navRoute.locationStart}');

      if (navStart.locationName.contains(navRoute.locationStart)) {
        print('run here');
        navRoutes.add(navRoute);
      }
    });

    return navRoutes;
  }

  static Future<List<NavStart>> getNavStartList() async {
    final navStartCoRef = FirebaseFirestore.instance.collection('navStarts');
    //dot operator takes precedence over await method
    final navStartQSnapshot = await navStartCoRef.get();
    final navStartQDocSnapshot = navStartQSnapshot.docs;
    final navStarts = List<NavStart>.empty(growable: true);

    navStartQDocSnapshot.forEach((doc) {
      final navStart = NavStart.fromJson(doc.data());
      navStarts.add(navStart);
    });

    return navStarts;
  }

  static Future<List<BusRoute>> getBusRouteList(
      {required BusStart busStart}) async {
    final busRoutesCoRef = FirebaseFirestore.instance.collection('busRoutes');
    //dot operator takes precedence over await method
    final busRoutesQSnapshot = await busRoutesCoRef.get();
    final busRoutesQDocSnapshot = busRoutesQSnapshot.docs;
    final busRoutes = List<BusRoute>.empty(growable: true);

    busRoutesQDocSnapshot.forEach((doc) {
      print('locationName: ${busStart.locationName}');

      final busRoute = BusRoute.fromJson(doc.data());

      print('locationStart: ${busRoute.locationStart}');

      if (busStart.locationName.contains(busRoute.locationStart)) {
        print('run here');
        busRoutes.add(busRoute);
      }
    });

    return busRoutes;
  }

  static Future<List<BusStart>> getBusStartList() async {
    final busStartCoRef = FirebaseFirestore.instance.collection('busStarts');
    //dot operator takes precedence over await method
    final busStartQSnapshot = await busStartCoRef.get();
    final busStartQDocSnapshot = busStartQSnapshot.docs;
    final busStarts = List<BusStart>.empty(growable: true);

    busStartQDocSnapshot.forEach((doc) {
      final busStart = BusStart.fromJson(doc.data());
      busStarts.add(busStart);
    });

    return busStarts;
  }
}
