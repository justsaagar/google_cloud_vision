import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:google_cloud_vision/app/helper/extension_helper.dart';
import 'package:google_cloud_vision/app/utills/app_utills.dart';
import 'package:google_cloud_vision/repository/label_detection_repository/label_detection_repository.dart';
import 'package:google_cloud_vision/serialized/label_detection_result_model.dart';
import 'package:google_vision/google_vision.dart';

class LabelDetectionRepositoryImpl implements LabelDetectionRepository {
  @override
  Future<List<LabelDetectionResult>> detectLabels(Uint8List imageBytes) async {
    try {
      final byteBuffer = imageBytes.buffer;
      final googleVision = await getGoogleVision(Get.context!);

      final List<EntityAnnotation> entityAnnotations = await googleVision.image.labelDetection(
        JsonImage.fromBuffer(byteBuffer),
      );

      return entityAnnotations.map((e) => LabelDetectionResult(data: e)).toList();
    } catch (e) {
      '$e'.logs();
      throw Exception('Error detecting labels: $e');
    }
  }
}
