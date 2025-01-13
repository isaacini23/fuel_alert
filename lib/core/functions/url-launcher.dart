import 'dart:developer';
import 'package:url_launcher/url_launcher.dart';

launchUrls(String url) async {
    (await canLaunchUrl(Uri.parse(url)))
        ? launchUrl(Uri.parse(url))
        : log("Cannot launch url");
  }