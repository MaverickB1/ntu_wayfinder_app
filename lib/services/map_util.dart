import 'package:url_launcher/url_launcher.dart';

class MapUtil {
  static Future<void> openMap(String url) async {
    await launch(url);
  }

  static Future<void> openBusMap(double north, double east) async {
    final googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$north,$east';
    await canLaunch(googleUrl);
  }
}
