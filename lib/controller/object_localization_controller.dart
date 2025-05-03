import 'package:get/get.dart';
import 'package:google_cloud_vision/main.dart';
import 'package:google_cloud_vision/repository/object_localization_repository/object_localization_repository.dart';

class ObjectLocalizationController extends GetxController {
  ObjectLocalizationRepository objectLocalizationRepository = getIt<ObjectLocalizationRepository>();
}