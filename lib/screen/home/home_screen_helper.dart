import 'package:google_cloud_vision/app/constant/app_asset.dart';
import 'package:google_cloud_vision/app/constant/string_constant.dart';
import 'package:google_cloud_vision/app/routes/route_helper.dart';
import 'package:google_cloud_vision/model/detection_model.dart';
import 'package:google_cloud_vision/screen/home/home_screen.dart';

class HomeScreenHelper {
  final HomeScreenState state;

  HomeScreenHelper(this.state);

  List<DetectionModel> detectionList = [
    DetectionModel(title: StringConstant.labelDetection, image: AppAsset.labelDetection, onTap: () => RouteHelper.instance.gotoLabelDetection(), description: StringConstant.labelDetectionDescription),
    DetectionModel(title: StringConstant.documentTextFile, image: AppAsset.documentFileDetection, onTap: () => RouteHelper.instance.gotoDocumentFileTextDetection(), description: StringConstant.documentFileDetectionDescription),
    DetectionModel(title: StringConstant.documentTextDetection, image: AppAsset.documentTextDetection, onTap: () => RouteHelper.instance.gotoDocumentTextDetection(), description: StringConstant.documentTextDetectionDescription),
    DetectionModel(title: StringConstant.faceDetection, image: AppAsset.faceDetection, onTap: () => RouteHelper.instance.gotoFaceDetection(), description: StringConstant.faceDetectionDescription),
    DetectionModel(title: StringConstant.landmarkDetection, image: AppAsset.landmarkDetection, onTap: () => RouteHelper.instance.gotoLandmarkDetection(), description: StringConstant.landmarkDetectionDescription),
    DetectionModel(title: StringConstant.logoDetection, image: AppAsset.logoDetection, onTap: () => RouteHelper.instance.gotoLogoDetection(), description: StringConstant.logoDetectionDescription),
    DetectionModel(title: StringConstant.imagePropertyDetection, image: AppAsset.imagePropertiesDetection, onTap: () => RouteHelper.instance.gotoImagePropertyDetection(), description: StringConstant.imagePropertyDetectionDescription),
    DetectionModel(title: StringConstant.webDetection, image: AppAsset.webDetection, onTap: () => RouteHelper.instance.gotoWebDetection(), description: StringConstant.webDetectionDescription),
    DetectionModel(title: StringConstant.objectLocalization, image: AppAsset.objectLocalization, onTap: () => RouteHelper.instance.gotoObjectLocalization(), description: StringConstant.objectLocalizationDescription),
  ];
}
