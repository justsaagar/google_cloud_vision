import 'package:get/get.dart';
import 'package:google_cloud_vision/main.dart';
import 'package:google_cloud_vision/repository/label_detection_repository/label_detection_repository.dart';

class LabelDetectionController extends GetxController {
  LabelDetectionRepository labelDetectionRepository = getIt<LabelDetectionRepository>();
}