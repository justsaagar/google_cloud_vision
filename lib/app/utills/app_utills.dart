import 'package:flutter/material.dart';
import 'package:google_vision/google_vision.dart';

Future<GoogleVision> getGoogleVision(BuildContext context) async {
  final credentials = await DefaultAssetBundle.of(context).loadString('assets/json/service_credentials.json');
  return await GoogleVision().withJwt(credentials);
}

String formatKeysToWords(String key) {
  return key
      .replaceAllMapped(
        RegExp(r'([a-z])([A-Z])'),
        (Match m) => '${m[1]} ${m[2]}',
      )
      .split(' ')
      .map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase())
      .join(' ');
}
