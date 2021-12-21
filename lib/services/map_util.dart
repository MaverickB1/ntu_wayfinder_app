import 'package:url_launcher/url_launcher.dart';

class MapUtil {
  MapUtil({required this.url});

  String url;

  static Future<void> openMap(String url) async {
    await launch(url);
  }
}
