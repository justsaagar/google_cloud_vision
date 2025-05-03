import 'dart:typed_data';

import 'package:google_cloud_vision/serialized/landmark_detection_result_model.dart';

abstract class LandmarkDetectionRepository {
  Future<List<LandmarkDetectionResult>> detectLandmarks(Uint8List imageBytes);
}
