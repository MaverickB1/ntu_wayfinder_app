import 'nav_step.dart';

class NavRoute {
  NavRoute(
      {required this.start,
      required this.destination,
      required this.id,
      required this.navSet});

  final String start;
  final String destination;
  final int id;
  final List<NavStep> navSet;

  static List<NavRoute> getSuggestions(String query) =>
      List.of(navRoutes).where((navRoute) {
        final navRouteLower = navRoute.start.toLowerCase();
        final queryLower = query.toLowerCase();

        return navRouteLower.contains(queryLower);
      }).toList();
}

List<NavRoute> navRoutes = [
  NavRoute(
      id: 1, start: 'Biz Library', destination: 'LWN Library', navSet: navSet1),
  NavRoute(
      id: 2, start: 'Biz Library', destination: 'Food Town', navSet: navSet2),
  NavRoute(id: 3, start: 'Biz Library', destination: 'LT 2A', navSet: navSet3),
  NavRoute(id: 4, start: 'Biz Library', destination: 'LT 19', navSet: navSet4),
  NavRoute(id: 5, start: 'Biz Library', destination: 'TCT LT', navSet: navSet5),
  NavRoute(
      id: 6,
      start: 'Biz Library',
      destination: 'SCSE Building',
      navSet: navSet6),
  NavRoute(
      id: 7,
      start: 'Biz Library',
      destination: 'MAE Building',
      navSet: navSet7),
  NavRoute(
      id: 8,
      start: 'Biz Library',
      destination: 'ASE Building',
      navSet: navSet8),
  NavRoute(
      id: 9,
      start: 'Biz Library',
      destination: 'Smoking Area',
      navSet: navSet9),
  NavRoute(
      id: 10,
      start: 'LWN Library',
      destination: 'Biz Library',
      navSet: navSet10),
  NavRoute(
      id: 11, start: 'LWN Library', destination: 'Food Town', navSet: navSet11),
  NavRoute(
      id: 12, start: 'LWN Library', destination: 'LT 2A', navSet: navSet12),
  NavRoute(
      id: 13, start: 'LWN Library', destination: 'LT 19', navSet: navSet13),
  NavRoute(
      id: 14, start: 'LWN Library', destination: 'TCT LT', navSet: navSet14),
  NavRoute(
      id: 15,
      start: 'LWN Library',
      destination: 'SCSE Building',
      navSet: navSet15),
  NavRoute(
      id: 16,
      start: 'LWN Library',
      destination: 'MAE Building',
      navSet: navSet16),
  NavRoute(
      id: 17,
      start: 'LWN Library',
      destination: 'ASE Building',
      navSet: navSet17),
  NavRoute(
      id: 18,
      start: 'LWN Library',
      destination: 'Smoking Area',
      navSet: navSet18),
  NavRoute(
      id: 19, start: 'Food Town', destination: 'Biz Library', navSet: navSet19),
  NavRoute(
      id: 20, start: 'Food Town', destination: 'LWN Library', navSet: navSet20),
  NavRoute(id: 21, start: 'Food Town', destination: 'LT 2A', navSet: navSet21),
  NavRoute(id: 22, start: 'Food Town', destination: 'LT 19', navSet: navSet22),
  NavRoute(id: 23, start: 'Food Town', destination: 'TCT LT', navSet: navSet23),
  NavRoute(
      id: 24,
      start: 'Food Town',
      destination: 'SCSE Building',
      navSet: navSet24),
  NavRoute(
      id: 25,
      start: 'Food Town',
      destination: 'MAE Building',
      navSet: navSet25),
  NavRoute(
      id: 26,
      start: 'Food Town',
      destination: 'ASE Building',
      navSet: navSet26),
  NavRoute(
      id: 27,
      start: 'Food Town',
      destination: 'Smoking Area',
      navSet: navSet27),
  NavRoute(
      id: 28, start: 'LT 2A', destination: 'Biz Library', navSet: navSet28),
  NavRoute(
      id: 29, start: 'LT 2A', destination: 'LWN Library', navSet: navSet29),
  NavRoute(id: 30, start: 'LT 2A', destination: 'Food Town', navSet: navSet30),
  NavRoute(id: 31, start: 'LT 2A', destination: 'LT 19', navSet: navSet31),
  NavRoute(id: 32, start: 'LT 2A', destination: 'TCT LT', navSet: navSet32),
  NavRoute(
      id: 33, start: 'LT 2A', destination: 'SCSE Building', navSet: navSet33),
  NavRoute(
      id: 34, start: 'LT 2A', destination: 'MAE Building', navSet: navSet34),
  NavRoute(
      id: 35, start: 'LT 2A', destination: 'ASE Building', navSet: navSet35),
  NavRoute(
      id: 36, start: 'LT 2A', destination: 'Smoking Area', navSet: navSet36),
];
