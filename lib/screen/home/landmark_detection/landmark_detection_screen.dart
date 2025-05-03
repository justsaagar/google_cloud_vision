import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_cloud_vision/app/constant/color_constant.dart';
import 'package:google_cloud_vision/app/constant/string_constant.dart';
import 'package:google_cloud_vision/app/utills/dimension.dart';
import 'package:google_cloud_vision/app/widgets/app_text.dart';
import 'package:google_cloud_vision/controller/landmark_detection_controller.dart';
import 'package:google_cloud_vision/app/widgets/chat_view.dart';
import 'package:google_cloud_vision/screen/home/landmark_detection/landmark_detection_helper.dart';
import 'package:google_cloud_vision/serialized/landmark_detection_result_model.dart';
import 'package:google_cloud_vision/serialized/message_model.dart';

class LandmarkDetectionScreen extends StatefulWidget {
  const LandmarkDetectionScreen({super.key});

  @override
  State<LandmarkDetectionScreen> createState() => LandmarkDetectionScreenState();
}

class LandmarkDetectionScreenState extends State<LandmarkDetectionScreen> {
  LandmarkDetectionHelper? helper;
  LandmarkDetectionController? controller;

  @override
  Widget build(BuildContext context) {
    helper ??= LandmarkDetectionHelper(this);
    return GetBuilder(
      init: LandmarkDetectionController(),
      builder: (LandmarkDetectionController landmarkDetectionController) {
        controller = landmarkDetectionController;
        return ChatScreen<LandmarkDetectionResult, LandmarkDetectionController>(
          title: StringConstant.landmarkDetection,
          messages: helper!.messages.cast<MessageModel<LandmarkDetectionResult>>(),
          image: helper!.image,
          isDetecting: helper!.isDetecting,
          controller: controller!,
          selectPrompt: StringConstant.selectImage,
          onSelect: helper!.pickImage,
          onDetect: helper!.detectLandmarks,
          onClearImage: helper!.clearImage,
          detectionRenderer: (results) {
            if (results.isEmpty) {
              return const AppText(
                'No landmarks detected.',
                fontSize: Dimens.textMedium,
                color: AppColorConstant.appBlack,
              );
            }
            return SelectableText.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '${StringConstant.detectedLandmarks}:\n',
                    style: const TextStyle(
                      fontSize: Dimens.textMedium,
                      fontWeight: FontWeight.bold,
                      color: AppColorConstant.appBlack,
                    ),
                  ),
                  ...results.asMap().entries.map((entry) {
                    final index = entry.key;
                    final landmark = entry.value.data;
                    return TextSpan(
                      text:
                      'Landmark ${index + 1}: ${landmark.description} (Score: ${landmark.score?.toStringAsFixed(2)})${index < results.length - 1 ? '\n' : ''}',
                      style: const TextStyle(
                        fontSize: Dimens.textMedium,
                        color: AppColorConstant.appBlack,
                      ),
                    );
                  }),
                ],
              ),
            );
          },
        );
      }
    );
  }
}