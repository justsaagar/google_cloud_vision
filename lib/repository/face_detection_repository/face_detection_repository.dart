import 'dart:typed_data';

import 'package:google_cloud_vision/serialized/face_detection_result_model.dart';

abstract class FaceDetectionRepository {
  Future<List<FaceDetectionResult>> detectFaces(Uint8List imageBytes);
}
