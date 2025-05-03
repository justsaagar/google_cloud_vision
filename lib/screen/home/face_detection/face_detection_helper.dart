import 'dart:io';
import 'package:flutter/scheduler.dart';
import 'package:google_cloud_vision/app/helper/app_enum.dart';
import 'package:google_cloud_vision/app/helper/extension_helper.dart';
import 'package:google_cloud_vision/app/utills/app_function.dart';
import 'package:google_cloud_vision/screen/home/face_detection/face_detection_screen.dart';
import 'package:google_cloud_vision/serialized/face_detection_result_model.dart';
import 'package:google_cloud_vision/serialized/message_model.dart';

class FaceDetectionHelper {
  final FaceDetectionScreenState state;
  File? image;
  List<MessageModel<FaceDetectionResult>> messages = [];
  bool isDetecting = false;

  FaceDetectionHelper(this.state) {
    SchedulerBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        messages.add(MessageModel(
          isUser: false,
          messageType: MessageType.text,
          content: 'Hello! Please select an image to detect faces.',
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

  Future<void> detectFaces() async {
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

      final faceDetectionResults = await state.controller?.faceDetectionRepository.detectFaces(bytes);

      messages.removeWhere((message) => message.messageType == MessageType.loading);
      isDetecting = false;

      messages.add(MessageModel(
        isUser: false,
        messageType: MessageType.detection,
        detectionType: DetectionType.face,
        content: '',
        detectionResults: faceDetectionResults!,
      ));
      updateState();
    } catch (e) {
      '$e'.logs();
      messages.removeWhere((message) => message.messageType == MessageType.loading);
      isDetecting = false;
      messages.add(MessageModel(
        isUser: false,
        messageType: MessageType.text,
        content: 'Error detecting faces: $e',
      ));
      updateState();
    }
  }
}
