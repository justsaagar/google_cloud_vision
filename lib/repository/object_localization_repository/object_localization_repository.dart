import 'dart:typed_data';

import 'package:google_cloud_vision/serialized/object_detection_result_model.dart';

abstract class ObjectLocalizationRepository {
  Future<List<ObjectDetectionResult>> detectObjects(Uint8List imageBytes);
}
