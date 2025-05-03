import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_cloud_vision/app/constant/color_constant.dart';
import 'package:google_cloud_vision/app/constant/string_constant.dart';
import 'package:google_cloud_vision/app/utills/dimension.dart';
import 'package:google_cloud_vision/controller/label_detection_controller.dart';
import 'package:google_cloud_vision/app/widgets/chat_view.dart';
import 'package:google_cloud_vision/screen/home/label_detection/label_detaction_screen_helper.dart';
import 'package:google_cloud_vision/serialized/label_detection_result_model.dart';
import 'package:google_cloud_vision/serialized/message_model.dart';

class LabelDetectionScreen extends StatefulWidget {
  const LabelDetectionScreen({super.key});

  @override
  State<LabelDetectionScreen> createState() => LabelDetectionScreenState();
}

class LabelDetectionScreenState extends State<LabelDetectionScreen> {
  LabelDetectionScreenHelper? helper;
  LabelDetectionController? controller;

  @override
  Widget build(BuildContext context) {
    helper ??= LabelDetectionScreenHelper(this);
    return GetBuilder(
        init: LabelDetectionController(),
        builder: (LabelDetectionController labelDetectionController) {
          controller = labelDetectionController;
          return ChatScreen<LabelDetectionResult, LabelDetectionController>(
            title: StringConstant.labelDetection,
            messages: helper!.messages.cast<MessageModel<LabelDetectionResult>>(),
            image: helper!.tempImage,
            isDetecting: helper!.isDetecting,
            controller: controller!,
            selectPrompt: StringConstant.selectImage,
            onSelect: () => helper!.pickImage(),
            onDetect: helper!.detectLabels,
            onClearImage: helper!.clearImage,
            detectionRenderer: (results) {
              return SelectableText.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '${StringConstant.detectedLabels}:\n',
                      style: const TextStyle(
                        fontSize: Dimens.textMedium,
                        fontWeight: FontWeight.bold,
                        color: AppColorConstant.appBlack,
                      ),
                    ),
                    ...results.asMap().entries.map(
                          (entry) => TextSpan(
                            text: '${entry.value.data.description} (Score: ${entry.value.data.score?.toStringAsFixed(2)})${entry.key < results.length - 1 ? '\n' : ''}',
                            style: const TextStyle(
                              fontSize: Dimens.textMedium,
                              color: AppColorConstant.appBlack,
                            ),
                          ),
                        ),
                  ],
                ),
              );
            },
          );
        });
  }
}
