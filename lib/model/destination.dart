import '../data/destination_data.dart';
import 'carpark.dart';

class Destination {
  Destination(
      {required this.destinationId,
      required this.destinationImage,
      required this.label,
      required this.carparks});

  final int destinationId;
  final String destinationImage;
  final String label;
  final List<Carpark> carparks;

  static List<Destination> getDestinationSuggestions(String query) =>
      List.of(destinations).where((destination) {
        final destinationLower = destination.label.toLowerCase();
        final queryLower = query.toLowerCase();

        return destinationLower.contains(queryLower);
      }).toList();

  factory Destination.fromJson(Map<String, dynamic> jsonData) {
    final jsonCarpark = jsonData['carparks'] as List;
    final carparkList = jsonCarpark.map((e) => Carpark.fromJson(e)).toList();

    return Destination(
      destinationId: jsonData['destinationId'] as int,
      destinationImage: jsonData['destinationImage'] as String,
      label: jsonData['label'] as String,
      carparks: carparkList,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'destinationId': destinationId,
        'destinationImage': destinationImage,
        'label': label,
        'carparks': carparks.map((e) => e.toJson()).toList(),
      };
}
