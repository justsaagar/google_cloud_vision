import 'package:get/get.dart';
import 'package:google_cloud_vision/main.dart';
import 'package:google_cloud_vision/repository/face_detection_repository/face_detection_repository.dart';

class FaceDetectionController extends GetxController {
  FaceDetectionRepository faceDetectionRepository = getIt<FaceDetectionRepository>();
}