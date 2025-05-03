import 'dart:typed_data';

import 'package:google_cloud_vision/serialized/logo_detection_result_model.dart';

abstract class LogoDetectionRepository {
  Future<List<LogoDetectionResult>> detectLogos(Uint8List imageBytes);
}
