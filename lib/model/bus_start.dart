class BusStart {
  BusStart({required this.locationName, required this.locationId});

  final String locationName;
  final int locationId;

  static List<BusStart> getFirestoreBusStartSuggestions(
          {required String query, required List<BusStart> data}) =>
      List.of(data).where((busStart) {
        final busStartLower = busStart.locationName.toLowerCase();

        return busStartLower.contains(query.toLowerCase());
      }).toList();

  factory BusStart.fromJson(Map<String, dynamic> jsonData) => BusStart(
      locationName: jsonData['locationName'] as String,
      locationId: jsonData['locationId'] as int);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'locationName': locationName,
        'locationId': locationId,
      };
}
