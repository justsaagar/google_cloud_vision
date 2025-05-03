import 'package:get/get.dart';
import 'package:google_cloud_vision/main.dart';
import 'package:google_cloud_vision/repository/image_property_detection_repository/image_property_detection_repository.dart';

class ImagePropertyDetectionController extends GetxController {
  ImagePropertyDetectionRepository imagePropertyDetectionRepository = getIt<ImagePropertyDetectionRepository>();
}
