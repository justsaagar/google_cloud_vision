import 'dart:io';

import 'package:flutter/scheduler.dart';
import 'package:google_cloud_vision/app/helper/app_enum.dart';
import 'package:google_cloud_vision/app/helper/extension_helper.dart';
import 'package:google_cloud_vision/app/utills/app_function.dart';
import 'package:google_cloud_vision/screen/home/image_property_detection/image_property_detection_screen.dart';
import 'package:google_cloud_vision/serialized/image_property_result_model.dart';
import 'package:google_cloud_vision/serialized/message_model.dart';

class ImagePropertyDetectionScreenHelper {
  ImagePropertyDetectionScreenState state;
  File? image;
  List<ImagePropertyResult> colors = [];
  List<MessageModel<ImagePropertyResult>> messages = [];
  bool isDetecting = false;

  ImagePropertyDetectionScreenHelper(this.state) {
    SchedulerBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        messages.add(MessageModel(
          isUser: false,
          messageType: MessageType.text,
          content: 'Hello! Please select an image to detect dominant colors.',
        ));
        updateState();
      },
    );
  }

  void updateState() => state.controller?.update();

  Future<void> pickImage() async {
    File? pickedFile = await AppFunction.selectImageFromCameraOrGallery();
    if (pickedFile == null) return;
    image = File(pickedFile.path);
    colors = [];
    updateState();
  }

  void clearImage() {
    image = null;
    colors = [];
    updateState();
  }

  Future<void> detectProperties() async {
    if (image == null) {
      messages.add(MessageModel(
        isUser: false,
        messageType: MessageType.text,
        content: 'Please select an image to detect dominant colors.',
      ));
      updateState();
      return;
    }

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
      image = null;
      updateState();

      final imagePropertyResults = await state.controller?.imagePropertyDetectionRepository.detectProperties(bytes);
      colors = imagePropertyResults!;

      messages.removeWhere((message) => message.messageType == MessageType.loading);
      isDetecting = false;

      if (colors.isEmpty) {
        messages.add(MessageModel(
          isUser: false,
          messageType: MessageType.text,
          content: 'No colors detected.',
        ));
      } else {
        messages.add(MessageModel(
          isUser: false,
          messageType: MessageType.detection,
          detectionType: DetectionType.imageProperty,
          content: '',
          detectionResults: colors,
        ));
      }
      updateState();
    } catch (e) {
      '$e'.logs();
      messages.removeWhere((message) => message.messageType == MessageType.loading);
      isDetecting = false;
      messages.add(MessageModel(
        isUser: false,
        messageType: MessageType.text,
        content: 'Error detecting dominant colors: $e',
      ));
      updateState();
    }
  }
}
