import 'package:get/get.dart';
import 'package:google_cloud_vision/app/routes/route_constant.dart';

class RouteHelper {
  static final RouteHelper instance = RouteHelper._internal();

  factory RouteHelper() => instance;

  RouteHelper._internal();

  void gotoBack() => Get.back();

  void gotoLabelDetection() => Get.toNamed(RouteConstant.labelDetection);

  void gotoDocumentFileTextDetection() => Get.toNamed(RouteConstant.documentTextFileDetection);

  void gotoDocumentTextDetection() => Get.toNamed(RouteConstant.documentTextDetection);

  void gotoFaceDetection() => Get.toNamed(RouteConstant.faceDetection);

  void gotoLandmarkDetection() => Get.toNamed(RouteConstant.landmarkDetection);

  void gotoLogoDetection() => Get.toNamed(RouteConstant.logoDetection);

  void gotoImagePropertyDetection() => Get.toNamed(RouteConstant.imagePropertyDetection);

  void gotoWebDetection() => Get.toNamed(RouteConstant.webDetection);

  void gotoObjectLocalization() => Get.toNamed(RouteConstant.objectLocalization);
}
