import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:google_cloud_vision/app/helper/extension_helper.dart';
import 'package:google_cloud_vision/app/utills/app_utills.dart';
import 'package:google_cloud_vision/repository/landmark_detection_repository/landmark_detection_repository.dart';
import 'package:google_cloud_vision/serialized/landmark_detection_result_model.dart';
import 'package:google_vision/google_vision.dart';

class LandmarkDetectionRepositoryImpl implements LandmarkDetectionRepository {
  @override
  Future<List<LandmarkDetectionResult>> detectLandmarks(Uint8List imageBytes) async {
    try {
      final byteBuffer = imageBytes.buffer;
      final googleVision = await getGoogleVision(Get.context!);

      final List<EntityAnnotation> landmarkAnnotations = await googleVision.image.landmarkDetection(
        JsonImage.fromBuffer(byteBuffer),
      );

      return landmarkAnnotations.map((landmark) => LandmarkDetectionResult(data: landmark)).toList();
    } catch (e) {
      '$e'.logs();
      throw Exception('Error detecting landmarks: $e');
    }
  }
}