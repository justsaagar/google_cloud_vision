import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:google_cloud_vision/app/helper/extension_helper.dart';
import 'package:google_cloud_vision/app/utills/app_utills.dart';
import 'package:google_cloud_vision/repository/face_detection_repository/face_detection_repository.dart';
import 'package:google_cloud_vision/serialized/face_detection_result_model.dart';
import 'package:google_vision/google_vision.dart';

class FaceDetectionRepositoryImpl implements FaceDetectionRepository {
  @override
  Future<List<FaceDetectionResult>> detectFaces(Uint8List imageBytes) async {
    try {
      final byteBuffer = imageBytes.buffer;
      final googleVision = await getGoogleVision(Get.context!);

      final List<FaceAnnotation> faceAnnotations = await googleVision.image.faceDetection(
        JsonImage.fromBuffer(byteBuffer),
      );

      return faceAnnotations.map((face) => FaceDetectionResult(data: face)).toList();
    } catch (e) {
      '$e'.logs();
      throw Exception('Error detecting faces: $e');
    }
  }
}
