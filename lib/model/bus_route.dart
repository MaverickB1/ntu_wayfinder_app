import 'bus_stop.dart';

class BusRoute {
  BusRoute({
    required this.locationStart,
    required this.locationEnd,
    required this.routeId,
    required this.busStops,
    required this.serviceIsRed,
    required this.mapLaunchUrl,
  });

  final String locationStart;
  final String locationEnd;
  final int routeId;
  final bool serviceIsRed;
  final String mapLaunchUrl;
  final List<BusStop> busStops;

  // static List<NavRoute> getNavRouteSuggestions(String query) =>
  //     List.of(navRoutes).where((navRoute) {
  //       final navRouteLower = navRoute.locationStart.toLowerCase();
  //       final queryLower = query.toLowerCase();

  //       return navRouteLower.contains(queryLower);
  //     }).toList();

  static List<BusRoute> getFirestoreBusRouteSuggestions(
          {required String query, required List<BusRoute> data}) =>
      List.of(data).where((busRoute) {
        final busRouteLower = busRoute.locationStart.toLowerCase();

        return busRouteLower.contains(query.toLowerCase());
      }).toList();

  factory BusRoute.fromJson(Map<String, dynamic> jsonData) {
    final jsonBusStop = jsonData['busStops'] as List;
    final busStopList = jsonBusStop.map((e) => BusStop.fromJson(e)).toList();

    return BusRoute(
      locationStart: jsonData['locationStart'] as String,
      locationEnd: jsonData['locationEnd'] as String,
      routeId: jsonData['routeId'] as int,
      serviceIsRed: jsonData['serviceIsRed'] as bool,
      mapLaunchUrl: jsonData['mapLaunchUrl'] as String,
      busStops: busStopList,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'locationStart': locationStart,
        'locationEnd': locationEnd,
        'routeId': routeId,
        'serviceIsRed': serviceIsRed,
        'mapLaunchUrl': mapLaunchUrl,
        'busStops': busStops.map((e) => e.toJson()).toList(),
      };
}
