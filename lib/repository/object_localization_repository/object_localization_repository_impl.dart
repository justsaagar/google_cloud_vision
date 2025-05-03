import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:google_cloud_vision/app/helper/extension_helper.dart';
import 'package:google_cloud_vision/app/utills/app_utills.dart';
import 'package:google_cloud_vision/repository/object_localization_repository/object_localization_repository.dart';
import 'package:google_cloud_vision/serialized/object_detection_result_model.dart';
import 'package:google_vision/google_vision.dart';

class ObjectLocalizationRepositoryImpl implements ObjectLocalizationRepository {
  @override
  Future<List<ObjectDetectionResult>> detectObjects(Uint8List imageBytes) async {
    try {
      final byteBuffer = imageBytes.buffer;
      final googleVision = await getGoogleVision(Get.context!);

      final List<LocalizedObjectAnnotation> objectAnnotations = await googleVision.image.objectLocalization(
        JsonImage.fromBuffer(byteBuffer),
      );

      return objectAnnotations.map((obj) => ObjectDetectionResult(data: obj)).toList();
    } catch (e) {
      '$e'.logs();
      throw Exception('Error detecting objects: $e');
    }
  }
}
