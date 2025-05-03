import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_cloud_vision/app/constant/color_constant.dart';
import 'package:google_cloud_vision/app/constant/string_constant.dart';
import 'package:google_cloud_vision/app/utills/dimension.dart';
import 'package:google_cloud_vision/app/widgets/app_text.dart';
import 'package:google_cloud_vision/controller/logo_detection_controller.dart';
import 'package:google_cloud_vision/app/widgets/chat_view.dart';
import 'package:google_cloud_vision/screen/home/logo_detection/logo_detection_helper.dart';
import 'package:google_cloud_vision/serialized/logo_detection_result_model.dart';
import 'package:google_cloud_vision/serialized/message_model.dart';

class LogoDetectionScreen extends StatefulWidget {
  const LogoDetectionScreen({super.key});

  @override
  State<LogoDetectionScreen> createState() => LogoDetectionScreenState();
}

class LogoDetectionScreenState extends State<LogoDetectionScreen> {
  LogoDetectionHelper? helper;
  LogoDetectionController? controller;

  @override
  Widget build(BuildContext context) {
    helper ??= LogoDetectionHelper(this);
    return GetBuilder(
        init: LogoDetectionController(),
        builder: (LogoDetectionController logoDetectionController) {
          controller = logoDetectionController;
          return ChatScreen<LogoDetectionResult, LogoDetectionController>(
            title: StringConstant.logoDetection,
            messages: helper!.messages.cast<MessageModel<LogoDetectionResult>>(),
            image: helper!.image,
            isDetecting: helper!.isDetecting,
            controller: controller!,
            selectPrompt: StringConstant.selectImage,
            onSelect: helper!.pickImage,
            onDetect: helper!.detectLogos,
            onClearImage: helper!.clearImage,
            detectionRenderer: (results) {
              if (results.isEmpty) {
                return const AppText(
                  'No logos detected.',
                  fontSize: Dimens.textMedium,
                  color: AppColorConstant.appBlack,
                );
              }
              return SelectableText.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '${StringConstant.detectedLogos}:\n',
                      style: const TextStyle(
                        fontSize: Dimens.textMedium,
                        fontWeight: FontWeight.bold,
                        color: AppColorConstant.appBlack,
                      ),
                    ),
                    ...results.asMap().entries.map((entry) {
                      final index = entry.key;
                      final logo = entry.value.data;
                      return TextSpan(
                        text: 'Logo ${index + 1}: ${logo.description} (Score: ${logo.score?.toStringAsFixed(2)})${index < results.length - 1 ? '\n' : ''}',
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
        });
  }
}
