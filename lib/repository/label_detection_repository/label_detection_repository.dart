import 'dart:typed_data';

import 'package:google_cloud_vision/serialized/label_detection_result_model.dart';

abstract class LabelDetectionRepository {
  Future<List<LabelDetectionResult>> detectLabels(Uint8List imageBytes);
}
