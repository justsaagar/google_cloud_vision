import 'package:get/get.dart';
import 'package:google_cloud_vision/main.dart';
import 'package:google_cloud_vision/repository/document_text_file_detection_repository/document_text_file_detection_repository.dart';

class DocumentTextFileDetectionController extends GetxController {
  DocumentTextFileDetectionRepository documentTextFileDetectionRepository = getIt<DocumentTextFileDetectionRepository>();
}