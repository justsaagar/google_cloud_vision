import 'package:get/get.dart';
import 'package:google_cloud_vision/main.dart';
import 'package:google_cloud_vision/repository/logo_detection_repository/logo_detection_repository.dart';

class LogoDetectionController extends GetxController {
  LogoDetectionRepository logoDetectionRepository = getIt<LogoDetectionRepository>();
}
