import 'package:get/get.dart';
import 'package:google_cloud_vision/screen/home/document_text_detection/document_text_detection_screen.dart';
import 'package:google_cloud_vision/screen/home/document_text_file_detection/document_text_file_detection_screen.dart';
import 'package:google_cloud_vision/screen/home/face_detection/face_detection_screen.dart';
import 'package:google_cloud_vision/screen/home/home_screen.dart';
import 'package:google_cloud_vision/screen/home/image_property_detection/image_property_detection_screen.dart';
import 'package:google_cloud_vision/screen/home/label_detection/label_detection_screen.dart';
import 'package:google_cloud_vision/screen/home/landmark_detection/landmark_detection_screen.dart';
import 'package:google_cloud_vision/screen/home/logo_detection/logo_detection_screen.dart';
import 'package:google_cloud_vision/screen/home/object_localization/object_localization_screen.dart';
import 'package:google_cloud_vision/screen/home/web_detection/web_detection_screen.dart';

class RouteConstant {
  static const String initial = '/';
  static const String labelDetection = '/labelDetection';
  static const String documentTextFileDetection = '/documentTextFileDetection';
  static const String documentTextDetection = '/documentTextDetection';
  static const String faceDetection = '/faceDetection';
  static const String landmarkDetection = '/landmarkDetection';
  static const String logoDetection = '/logoDetection';
  static const String imagePropertyDetection = '/imagePropertyDetection';
  static const String webDetection = '/webDetection';
  static const String objectLocalization = '/objectLocalization';
}

class GetPageRouteHelper {
  static List<GetPage> routes = [
    GetPage(name: RouteConstant.initial, page: () => const HomeScreen()),
    GetPage(name: RouteConstant.labelDetection, page: () => const LabelDetectionScreen()),
    GetPage(name: RouteConstant.documentTextFileDetection, page: () => const DocumentTextFileDetectionScreen()),
    GetPage(name: RouteConstant.documentTextDetection, page: () => const DocumentTextDetectionScreen()),
    GetPage(name: RouteConstant.faceDetection, page: () => const FaceDetectionScreen()),
    GetPage(name: RouteConstant.landmarkDetection, page: () => const LandmarkDetectionScreen()),
    GetPage(name: RouteConstant.logoDetection, page: () => const LogoDetectionScreen()),
    GetPage(name: RouteConstant.imagePropertyDetection, page: () => const ImagePropertyDetectionScreen()),
    GetPage(name: RouteConstant.webDetection, page: () => const WebDetectionScreen()),
    GetPage(name: RouteConstant.objectLocalization, page: () => const ObjectLocalizationScreen()),
  ];
}
