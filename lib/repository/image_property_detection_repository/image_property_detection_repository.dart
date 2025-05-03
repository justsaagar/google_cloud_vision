import 'dart:typed_data';

import 'package:google_cloud_vision/serialized/image_property_result_model.dart';

abstract class ImagePropertyDetectionRepository {
  Future<List<ImagePropertyResult>> detectProperties(Uint8List imageBytes);
}
