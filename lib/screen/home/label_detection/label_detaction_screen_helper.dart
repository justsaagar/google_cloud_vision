import 'dart:io';
import 'package:flutter/scheduler.dart';
import 'package:google_cloud_vision/app/helper/app_enum.dart';
import 'package:google_cloud_vision/app/helper/extension_helper.dart';
import 'package:google_cloud_vision/app/utills/app_function.dart';
import 'package:google_cloud_vision/screen/home/label_detection/label_detection_screen.dart';
import 'package:google_cloud_vision/serialized/label_detection_result_model.dart';
import 'package:google_cloud_vision/serialized/message_model.dart';

class LabelDetectionScreenHelper {
  LabelDetectionScreenState state;
  File? tempImage;
  List<LabelDetectionResult> labels = [];
  List<MessageModel<LabelDetectionResult>> messages = [];
  bool isDetecting = false;

  LabelDetectionScreenHelper(this.state) {
    SchedulerBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        messages.add(MessageModel(
          isUser: false,
          messageType: MessageType.text,
          content: 'Hello! Please select an image to detect labels.',
        ));
        updateState();
      },
    );
  }

  void updateState() => state.controller?.update();

  Future<void> pickImage() async {
    File? pickedFile = await AppFunction.selectImageFromCameraOrGallery();
    if (pickedFile == null) return;
    tempImage = File(pickedFile.path);
    labels = [];
    updateState();
  }

  void clearImage() {
    tempImage = null;
    labels = [];
    updateState();
  }

  Future<void> detectLabels() async {
    if (tempImage == null) return;

    try {
      messages.add(MessageModel(
        isUser: true,
        messageType: MessageType.image,
        content: tempImage!.path,
      ));

      isDetecting = true;
      messages.add(MessageModel(
        isUser: false,
        messageType: MessageType.loading,
        content: '',
      ));
      updateState();

      final bytes = await tempImage!.readAsBytes();
      tempImage = null;
      updateState();

      final labelDetectionResults = await state.controller?.labelDetectionRepository.detectLabels(bytes);
      labels = labelDetectionResults!;

      messages.removeWhere((message) => message.messageType == MessageType.loading);
      isDetecting = false;

      messages.add(MessageModel(
        isUser: false,
        messageType: MessageType.detection,
        detectionType: DetectionType.label,
        content: '',
        detectionResults: labels,
      ));
      updateState();
    } catch (e) {
      '$e'.logs();
      messages.removeWhere((message) => message.messageType == MessageType.loading);
      isDetecting = false;
      messages.add(MessageModel(
        isUser: false,
        messageType: MessageType.text,
        content: 'Error detecting labels: $e',
      ));
      updateState();
    }
  }
}
