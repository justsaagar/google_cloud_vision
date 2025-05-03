import 'dart:typed_data';

import 'package:google_cloud_vision/serialized/text_detection_result_model.dart';

abstract class DocumentTextDetectionRepository {
  Future<TextDetectionResult> detectText(Uint8List imageBytes);
}
