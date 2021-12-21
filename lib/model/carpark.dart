class Carpark {
  Carpark(
      {required this.carparkId,
      required this.carparkImage,
      required this.opsInfo,
      required this.charge,
      required this.hourCost,
      required this.mapLaunchUrl});

  final String carparkId;
  final String carparkImage;
  final String opsInfo;
  final String charge;
  final double hourCost;
  final String mapLaunchUrl;

  factory Carpark.fromJson(Map<String, dynamic> jsonData) {
    return Carpark(
      carparkId: jsonData['carparkId'] as String,
      carparkImage: jsonData['carparkImage'] as String,
      opsInfo: jsonData['opsInfo'] as String,
      charge: jsonData['charge'] as String,
      hourCost: jsonData['hourCost'] as double,
      mapLaunchUrl: jsonData['mapLaunchUrl'],
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'carparkId': carparkId,
        'carparkImage': carparkImage,
        'opsInfo': opsInfo,
        'charge': charge,
        'hourCost': hourCost,
        'mapLaunchUrl': mapLaunchUrl,
      };
}
