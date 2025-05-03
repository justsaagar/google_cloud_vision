import 'package:flutter/material.dart';
import 'package:google_cloud_vision/app/helper/app_enum.dart';
import 'package:google_cloud_vision/screen/home/document_text_file_detection/document_text_file_detection_screen.dart';
import 'package:google_cloud_vision/serialized/message_model.dart';
import 'package:google_cloud_vision/serialized/text_detection_result_model.dart';
import 'package:universal_io/io.dart';
import 'package:file_picker/file_picker.dart';

class DocumentTextFileDetectionScreenHelper {
  final DocumentTextFileDetectionScreenState state;
  List<MessageModel<TextDetectionResult>> messages = [];
  String? fileName;
  LoadingStatus loadingStatus = LoadingStatus.initial;

  DocumentTextFileDetectionScreenHelper(this.state) {
    messages.add(MessageModel(
      isUser: false,
      messageType: MessageType.text,
      content: 'Hello! Please upload a PDF file to extract text.',
    ));
    updateState();
  }

  void updateState() => state.controller?.update();

  Future<FilePickerResult?> pickPdfFile() async {
    return await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
  }

  Future<void> pickAndProcessFile(BuildContext context) async {
    try {
      FilePickerResult? result = await pickPdfFile();

      if (result != null && result.files.single.path != null) {
        final filePath = result.files.single.path!;
        fileName = result.files.single.name;

        messages.add(MessageModel(
          isUser: true,
          messageType: MessageType.file,
          content: fileName!,
        ));

        messages.add(MessageModel(
          isUser: false,
          messageType: MessageType.loading,
          content: '',
        ));
        loadingStatus = LoadingStatus.loading;
        updateState();

        final file = File(filePath);
        final bytes = await file.readAsBytes();
        final processedResult = await state.controller?.documentTextFileDetectionRepository.detectTextFromFile(bytes);

        messages.removeWhere((message) => message.messageType == MessageType.loading);
        loadingStatus = LoadingStatus.success;

        messages.add(MessageModel(
          isUser: false,
          messageType: MessageType.detection,
          detectionType: DetectionType.text,
          content: '',
          detectionResults: [processedResult!],
        ));
        updateState();
      } else {
        messages.add(MessageModel(
          isUser: false,
          messageType: MessageType.text,
          content: 'No file selected.',
        ));
        loadingStatus = LoadingStatus.failed;
        updateState();
      }
    } catch (e) {
      messages.removeWhere((message) => message.messageType == MessageType.loading);
      loadingStatus = LoadingStatus.failure;
      messages.add(MessageModel(
        isUser: false,
        messageType: MessageType.text,
        content: 'Error: $e',
      ));
      updateState();
    }
  }
}
