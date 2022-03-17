import 'nav_step.dart';

class NavRoute {
  NavRoute(
      {required this.locationStart,
      required this.locationEnd,
      required this.routeId,
      required this.navSteps});

  final String locationStart;
  final String locationEnd;
  final int routeId;
  final List<NavStep> navSteps;

  static List<NavRoute> getFirestoreNavRouteSuggestions(
          {required String query, required List<NavRoute> data}) =>
      List.of(data).where((navRoute) {
        final navRouteLower = navRoute.locationStart.toLowerCase();
        final queryLower = query.toLowerCase();

        return navRouteLower.contains(queryLower);
      }).toList();

  factory NavRoute.fromJson(Map<String, dynamic> jsonData) {
    final jsonNavStep = jsonData['navSteps'] as List;
    final navStepList = jsonNavStep.map((e) => NavStep.fromJson(e)).toList();

    return NavRoute(
      locationStart: jsonData['locationStart'] as String,
      locationEnd: jsonData['locationEnd'] as String,
      routeId: jsonData['routeId'] as int,
      navSteps: navStepList,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'locationStart': locationStart,
        'locationEnd': locationEnd,
        'routeId': routeId,
        'navSteps': navSteps.map((e) => e.toJson()).toList(),
      };
}
