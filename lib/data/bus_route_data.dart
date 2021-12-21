import '../model/bus_route.dart';
import 'bus_stop_data.dart';

List<BusRoute> busRoutes = [
  BusRoute(
      routeId: 1,
      locationStart: 'Hall 1',
      locationEnd: 'North Spine',
      busStops: [
        busStops[0],
        busStops[2],
        busStops[4],
        busStops[6],
        busStops[8],
      ]),
  BusRoute(
      routeId: 2,
      locationStart: 'Hall 1',
      locationEnd: 'South Spine',
      busStops: [
        busStops[1],
        busStops[3],
        busStops[5],
        busStops[7],
        busStops[9],
      ]),
];
