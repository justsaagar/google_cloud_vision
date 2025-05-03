import 'dart:typed_data';

import 'package:google_cloud_vision/serialized/web_detection_result_model.dart';

abstract class WebDetectionRepository {
  Future<List<WebDetectionResult>> detectWeb(Uint8List imageBytes);
}
