class BusStop {
  BusStop(
      {required this.stopId,
      required this.imageUrl});

  final int stopId;
  final String imageUrl;

  factory BusStop.fromJson(Map<String, dynamic> jsonData) {
    return BusStop(
      stopId: jsonData['stopId'] as int,
      imageUrl: jsonData['imageUrl'] as String,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'stopId': stopId,
        'imageUrl': imageUrl,
      };
}