class NavRoute {
  NavRoute({required this.start, required this.destination, required this.id});

  final String start;
  final String destination;
  final int id;

  static List<NavRoute> getSuggestions(String query) =>
      List.of(navRoutes).where((navRoute) {
        final navRouteLower = navRoute.start.toLowerCase();
        final queryLower = query.toLowerCase();

        return navRouteLower.contains(queryLower);
      }).toList();
}

List<NavRoute> navRoutes = [
  NavRoute(id: 1, start: 'Biz Library', destination: 'LWN Library'),
  NavRoute(id: 2, start: 'Biz Library', destination: 'Food Town'),
  NavRoute(id: 3, start: 'Biz Library', destination: 'LT 2A'),
  NavRoute(id: 4, start: 'Biz Library', destination: 'LT 19'),
  NavRoute(id: 5, start: 'Biz Library', destination: 'TCT LT'),
  NavRoute(id: 6, start: 'Biz Library', destination: 'SCSE Building'),
  NavRoute(id: 7, start: 'Biz Library', destination: 'MAE Building'),
  NavRoute(id: 8, start: 'Biz Library', destination: 'ASE Building'),
  NavRoute(id: 9, start: 'Biz Library', destination: 'Smoking Area'),
  NavRoute(id: 10, start: 'LWN Library', destination: 'Biz Library'),
  NavRoute(id: 11, start: 'LWN Library', destination: 'Food Town'),
  NavRoute(id: 12, start: 'LWN Library', destination: 'LT 2A'),
  NavRoute(id: 13, start: 'LWN Library', destination: 'LT 19'),
  NavRoute(id: 14, start: 'LWN Library', destination: 'TCT LT'),
  NavRoute(id: 15, start: 'LWN Library', destination: 'SCSE Building'),
  NavRoute(id: 16, start: 'LWN Library', destination: 'MAE Building'),
  NavRoute(id: 17, start: 'LWN Library', destination: 'ASE Building'),
  NavRoute(id: 18, start: 'LWN Library', destination: 'Smoking Area'),
  NavRoute(id: 19, start: 'Food Town', destination: 'Biz Library'),
  NavRoute(id: 20, start: 'Food Town', destination: 'LWN Library'),
  NavRoute(id: 21, start: 'Food Town', destination: 'LT 2A'),
  NavRoute(id: 22, start: 'Food Town', destination: 'LT 19'),
  NavRoute(id: 23, start: 'Food Town', destination: 'TCT LT'),
  NavRoute(id: 24, start: 'Food Town', destination: 'SCSE Building'),
  NavRoute(id: 25, start: 'Food Town', destination: 'MAE Building'),
  NavRoute(id: 26, start: 'Food Town', destination: 'ASE Building'),
  NavRoute(id: 27, start: 'Food Town', destination: 'Smoking Area'),
  NavRoute(id: 28, start: 'LT 2A', destination: 'Biz Library'),
  NavRoute(id: 29, start: 'LT 2A', destination: 'LWN Library'),
  NavRoute(id: 30, start: 'LT 2A', destination: 'Food Town'),
  NavRoute(id: 31, start: 'LT 2A', destination: 'LT 19'),
  NavRoute(id: 32, start: 'LT 2A', destination: 'TCT LT'),
  NavRoute(id: 33, start: 'LT 2A', destination: 'SCSE Building'),
  NavRoute(id: 34, start: 'LT 2A', destination: 'MAE Building'),
  NavRoute(id: 35, start: 'LT 2A', destination: 'ASE Building'),
  NavRoute(id: 36, start: 'LT 2A', destination: 'Smoking Area'),
];
