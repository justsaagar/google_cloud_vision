import 'dart:typed_data';

import 'package:google_cloud_vision/serialized/text_detection_result_model.dart';

abstract class DocumentTextFileDetectionRepository {
  Future<TextDetectionResult> detectTextFromFile(Uint8List fileBytes);
}
