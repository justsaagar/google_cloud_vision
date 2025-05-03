import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_cloud_vision/app/constant/color_constant.dart';
import 'package:google_cloud_vision/app/constant/string_constant.dart';
import 'package:google_cloud_vision/app/utills/dimension.dart';
import 'package:google_cloud_vision/app/widgets/app_text.dart';
import 'package:google_cloud_vision/controller/object_localization_controller.dart';
import 'package:google_cloud_vision/app/widgets/chat_view.dart';
import 'package:google_cloud_vision/screen/home/object_localization/object_localization_helper.dart';
import 'package:google_cloud_vision/serialized/message_model.dart';
import 'package:google_cloud_vision/serialized/object_detection_result_model.dart';

class ObjectLocalizationScreen extends StatefulWidget {
  const ObjectLocalizationScreen({super.key});

  @override
  State<ObjectLocalizationScreen> createState() => ObjectLocalizationScreenState();
}

class ObjectLocalizationScreenState extends State<ObjectLocalizationScreen> {
  ObjectLocalizationHelper? helper;
  ObjectLocalizationController? controller;

  @override
  Widget build(BuildContext context) {
    helper ??= ObjectLocalizationHelper(this);
    return GetBuilder(
      init: ObjectLocalizationController(),
      builder: (ObjectLocalizationController objectLocalizationController) {
        controller = objectLocalizationController;
        return ChatScreen<ObjectDetectionResult, ObjectLocalizationController>(
          title: StringConstant.objectLocalization,
          messages: helper!.messages.cast<MessageModel<ObjectDetectionResult>>(),
          image: helper!.image,
          isDetecting: helper!.isDetecting,
          controller: controller!,
          selectPrompt: StringConstant.selectImage,
          onSelect: helper!.pickImage,
          onDetect: helper!.detectObjects,
          onClearImage: helper!.clearImage,
          detectionRenderer: (results) {
            if (results.isEmpty) {
              return const AppText(
                'No objects detected.',
                fontSize: Dimens.textMedium,
                color: AppColorConstant.appBlack,
              );
            }
            return SelectableText.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '${StringConstant.detectedObjects}:\n',
                    style: const TextStyle(
                      fontSize: Dimens.textMedium,
                      fontWeight: FontWeight.bold,
                      color: AppColorConstant.appBlack,
                    ),
                  ),
                  ...results.asMap().entries.map((entry) {
                    final index = entry.key;
                    final object = entry.value.data;
                    return TextSpan(
                      text:
                      'Object ${index + 1}: ${object.name} (Score: ${object.score?.toStringAsFixed(2)})\nBounding Poly: ${object.boundingPoly?.normalizedVertices.map((v) => '(${v.x}, ${v.y})').join(', ')}${index < results.length - 1 ? '\n' : ''}',
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