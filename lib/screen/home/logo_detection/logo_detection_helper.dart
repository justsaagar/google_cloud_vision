import 'dart:io';

import 'package:flutter/scheduler.dart';
import 'package:google_cloud_vision/app/helper/app_enum.dart';
import 'package:google_cloud_vision/app/helper/extension_helper.dart';
import 'package:google_cloud_vision/app/utills/app_function.dart';
import 'package:google_cloud_vision/screen/home/logo_detection/logo_detection_screen.dart';
import 'package:google_cloud_vision/serialized/logo_detection_result_model.dart';
import 'package:google_cloud_vision/serialized/message_model.dart';

class LogoDetectionHelper {
  final LogoDetectionScreenState state;
  File? image;
  List<MessageModel<LogoDetectionResult>> messages = [];
  bool isDetecting = false;

  LogoDetectionHelper(this.state) {
    SchedulerBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        messages.add(MessageModel(
          isUser: false,
          messageType: MessageType.text,
          content: 'Hello! Please select an image to detect logos.',
        ));
        updateState();
      },
    );
  }

  void updateState() => state.controller?.update();

  Future<void> pickImage() async {
    File? pickedFile = await AppFunction.selectImageFromCameraOrGallery();
    if (pickedFile != null) {
      image = File(pickedFile.path);
    }
    updateState();
  }

  void clearImage() {
    image = null;
    updateState();
  }

  Future<void> detectLogos() async {
    if (image == null) return;

    try {
      messages.add(MessageModel(
        isUser: true,
        messageType: MessageType.image,
        content: image!.path,
      ));
      isDetecting = true;
      messages.add(MessageModel(
        isUser: false,
        messageType: MessageType.loading,
        content: '',
      ));
      updateState();

      final bytes = await image!.readAsBytes();
      clearImage();

      final logoDetectionResults = await state.controller?.logoDetectionRepository.detectLogos(bytes);

      messages.removeWhere((message) => message.messageType == MessageType.loading);
      isDetecting = false;

      messages.add(MessageModel(
        isUser: false,
        messageType: MessageType.detection,
        detectionType: DetectionType.logo,
        content: '',
        detectionResults: logoDetectionResults!,
      ));
      updateState();
    } catch (e) {
      '$e'.logs();
      messages.removeWhere((message) => message.messageType == MessageType.loading);
      isDetecting = false;
      messages.add(MessageModel(
        isUser: false,
        messageType: MessageType.text,
        content: 'Error detecting logos: $e',
      ));
      updateState();
    }
  }
}
