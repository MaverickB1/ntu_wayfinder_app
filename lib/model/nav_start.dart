class NavStart {
  NavStart(
      {required this.locationName,
      required this.locationId,
      required this.locationImage});

  final String locationName;
  final int locationId;
  final String locationImage;

  // static List<NavRoute> getNavRouteSuggestions(String query) =>
  //     List.of(navRoutes).where((navRoute) {
  //       final navRouteLower = navRoute.locationStart.toLowerCase();
  //       final queryLower = query.toLowerCase();

  //       return navRouteLower.contains(queryLower);
  //     }).toList();

  static List<NavStart> getFirestoreNavStartSuggestions(
          {required String query, required List<NavStart> data}) =>
      List.of(data).where((navStart) {
        final navStartLower = navStart.locationName.toLowerCase();
        final queryLower = query.toLowerCase();

        return navStartLower.contains(queryLower);
      }).toList();

  factory NavStart.fromJson(Map<String, dynamic> jsonData) => NavStart(
      locationName: jsonData['locationName'] as String,
      locationId: jsonData['locationId'] as int,
      locationImage: jsonData['locationImage'] as String);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'locationName': locationName,
        'locationId': locationId,
        'locationImage': locationImage,
      };
}
