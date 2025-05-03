import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:google_cloud_vision/app/helper/extension_helper.dart';
import 'package:google_cloud_vision/app/utills/app_utills.dart';
import 'package:google_cloud_vision/repository/logo_detection_repository/logo_detection_repository.dart';
import 'package:google_cloud_vision/serialized/logo_detection_result_model.dart';
import 'package:google_vision/google_vision.dart';

class LogoDetectionRepositoryImpl implements LogoDetectionRepository {
  @override
  Future<List<LogoDetectionResult>> detectLogos(Uint8List imageBytes) async {
    try {
      final byteBuffer = imageBytes.buffer;
      final googleVision = await getGoogleVision(Get.context!);

      final List<EntityAnnotation> logoAnnotations = await googleVision.image.logoDetection(
        JsonImage.fromBuffer(byteBuffer),
      );

      return logoAnnotations.map((logo) => LogoDetectionResult(data: logo)).toList();
    } catch (e) {
      '$e'.logs();
      throw Exception('Error detecting logos: $e');
    }
  }
}
