import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_cloud_vision/repository/document_text_detection_repository/document_text_detection_repository.dart';
import 'package:google_cloud_vision/repository/document_text_detection_repository/document_text_detection_repository_impl.dart';
import 'package:google_cloud_vision/repository/document_text_file_detection_repository/document_text_file_detection_repository.dart';
import 'package:google_cloud_vision/repository/document_text_file_detection_repository/document_text_file_detection_repository_impl.dart';
import 'package:google_cloud_vision/repository/face_detection_repository/face_detection_repository.dart';
import 'package:google_cloud_vision/repository/face_detection_repository/face_detection_repository_impl.dart';
import 'package:google_cloud_vision/repository/image_property_detection_repository/image_property_detection_repository.dart';
import 'package:google_cloud_vision/repository/image_property_detection_repository/image_property_detection_repository_impl.dart';
import 'package:google_cloud_vision/repository/label_detection_repository/label_detection_repository.dart';
import 'package:google_cloud_vision/repository/label_detection_repository/label_detection_repository_impl.dart';
import 'package:google_cloud_vision/repository/landmark_detection_repository/landmark_detection_repository.dart';
import 'package:google_cloud_vision/repository/landmark_detection_repository/landmark_detection_repository_impl.dart';
import 'package:google_cloud_vision/repository/logo_detection_repository/logo_detection_repository.dart';
import 'package:google_cloud_vision/repository/logo_detection_repository/logo_detection_repository_impl.dart';
import 'package:google_cloud_vision/repository/object_localization_repository/object_localization_repository.dart';
import 'package:google_cloud_vision/repository/object_localization_repository/object_localization_repository_impl.dart';
import 'package:google_cloud_vision/repository/web_detection_repository/web_detection_repository.dart';
import 'package:google_cloud_vision/repository/web_detection_repository/web_detection_repository_impl.dart';

import 'app/routes/route_constant.dart';

final GetIt getIt = GetIt.instance;

init() async {
  getIt.registerSingleton<DocumentTextDetectionRepository>(DocumentTextDetectionRepositoryImpl());
  getIt.registerSingleton<DocumentTextFileDetectionRepository>(DocumentTextFileDetectionRepositoryImpl());
  getIt.registerSingleton<FaceDetectionRepository>(FaceDetectionRepositoryImpl());
  getIt.registerSingleton<ImagePropertyDetectionRepository>(ImagePropertyDetectionRepositoryImpl());
  getIt.registerSingleton<LabelDetectionRepository>(LabelDetectionRepositoryImpl());
  getIt.registerSingleton<LandmarkDetectionRepository>(LandmarkDetectionRepositoryImpl());
  getIt.registerSingleton<LogoDetectionRepository>(LogoDetectionRepositoryImpl());
  getIt.registerSingleton<ObjectLocalizationRepository>(ObjectLocalizationRepositoryImpl());
  getIt.registerSingleton<WebDetectionRepository>(WebDetectionRepositoryImpl());
}

Future<void> main() async {
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: GetMaterialApp(
          title: 'Google Cloud Vision',
          locale: const Locale('en'),
          debugShowCheckedModeBanner: false,
          initialRoute: RouteConstant.initial,
          getPages: GetPageRouteHelper.routes,
          builder: (context, child) {
            Widget appContent = MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
              child: child ?? Container(),
            );
            return appContent;
          },
        ),
      ),
    );
  }
}
