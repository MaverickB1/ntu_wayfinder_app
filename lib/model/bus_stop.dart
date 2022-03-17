class BusStop {
  BusStop({
    required this.stopId,
    required this.stopImage,
    required this.stopName,
    required this.travelDuration,
    required this.isStop,
    required this.isAlight,
    // required this.isTransit
  });

  final int stopId;
  final String stopImage;
  final String stopName;
  final int travelDuration;
  final bool isStop;
  final bool isAlight;
  // final bool isTransit;

  factory BusStop.fromJson(Map<String, dynamic> jsonData) {
    return BusStop(
      stopId: jsonData['stopId'] as int,
      stopImage: jsonData['stopImage'] as String,
      stopName: jsonData['stopName'] as String,
      travelDuration: jsonData['travelDuration'] as int,
      isStop: jsonData['isStop'] as bool,
      isAlight: jsonData['isAlight'] as bool,
      // isTransit: jsonData['isTransit'] as bool,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'stopId': stopId,
        'stopImage': stopImage,
        'stopName': stopName,
        'travelDuration': travelDuration,
        'isStop': isStop,
        'isAlight': isAlight,
        // 'isTransit': isTransit,
      };
}
