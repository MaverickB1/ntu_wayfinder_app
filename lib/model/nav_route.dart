import '../data/nav_route_data.dart';

import 'nav_step.dart';

class NavRoute {
  NavRoute(
      {required this.start,
      required this.destination,
      required this.id,
      required this.navSteps});

  final String start;
  final String destination;
  final int id;
  final List<NavStep> navSteps;

  static List<NavRoute> getSuggestions(String query) =>
      List.of(navRoutes).where((navRoute) {
        final navRouteLower = navRoute.start.toLowerCase();
        final queryLower = query.toLowerCase();

        return navRouteLower.contains(queryLower);
      }).toList();
}
