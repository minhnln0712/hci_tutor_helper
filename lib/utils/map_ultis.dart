import 'dart:developer';

import 'package:url_launcher/url_launcher.dart';

class MapUtil {
  MapUtil._();

  static Future<void> openMap(String uri) async {
    String ggmapUrl = "http://maps.google.com/?q=$uri";
    if (await canLaunch(ggmapUrl)) {
      await launch(ggmapUrl);
    } else {
      log("Can't open gg MAP!!!");
    }
  }
}
