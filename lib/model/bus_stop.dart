class BusStop {
  BusStop(
      {required this.stopId,
      required this.stopImage,
      required this.stopName,
      required this.travelDuration});

  final int stopId;
  final String stopImage;
  final String stopName;
  final int travelDuration;

  factory BusStop.fromJson(Map<String, dynamic> jsonData) {
    return BusStop(
      stopId: jsonData['stopId'] as int,
      stopImage: jsonData['stopImage'] as String,
      stopName: jsonData['stopName'] as String,
      travelDuration: jsonData['travelDuration'] as int,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'stopId': stopId,
        'stopImage': stopImage,
        'stopName': stopName,
        'travelDuration': travelDuration,
      };
}
