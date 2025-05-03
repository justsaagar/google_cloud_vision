import 'package:get/get.dart';
import 'package:google_cloud_vision/main.dart';
import 'package:google_cloud_vision/repository/web_detection_repository/web_detection_repository.dart';

class WebDetectionController extends GetxController {
  WebDetectionRepository webDetectionRepository = getIt<WebDetectionRepository>();
}