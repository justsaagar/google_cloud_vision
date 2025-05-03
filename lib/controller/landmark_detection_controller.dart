import 'package:get/get.dart';
import 'package:google_cloud_vision/main.dart';
import 'package:google_cloud_vision/repository/landmark_detection_repository/landmark_detection_repository.dart';

class LandmarkDetectionController extends GetxController {
  LandmarkDetectionRepository landmarkDetectionRepository = getIt<LandmarkDetectionRepository>();
}