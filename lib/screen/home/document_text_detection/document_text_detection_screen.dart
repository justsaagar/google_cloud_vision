import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_cloud_vision/app/constant/color_constant.dart';
import 'package:google_cloud_vision/app/constant/string_constant.dart';
import 'package:google_cloud_vision/app/utills/dimension.dart';
import 'package:google_cloud_vision/controller/document_text_detection_controller.dart';
import 'package:google_cloud_vision/app/widgets/chat_view.dart';
import 'package:google_cloud_vision/screen/home/document_text_detection/document_text_detection_helper.dart';
import 'package:google_cloud_vision/serialized/message_model.dart';
import 'package:google_cloud_vision/serialized/text_detection_result_model.dart';

class DocumentTextDetectionScreen extends StatefulWidget {
  const DocumentTextDetectionScreen({super.key});

  @override
  State<DocumentTextDetectionScreen> createState() => DocumentTextDetectionScreenState();
}

class DocumentTextDetectionScreenState extends State<DocumentTextDetectionScreen> {
  DocumentTextDetectionHelper? helper;
  DocumentTextDetectionController? controller;

  @override
  Widget build(BuildContext context) {
    helper ??= DocumentTextDetectionHelper(this);
    return GetBuilder(
        init: DocumentTextDetectionController(),
        builder: (DocumentTextDetectionController documentTextDetectionController) {
          controller = documentTextDetectionController;
          return ChatScreen<TextDetectionResult, DocumentTextDetectionController>(
            title: StringConstant.documentTextDetection,
            messages: helper!.messages.cast<MessageModel<TextDetectionResult>>(),
            image: helper!.image,
            isDetecting: helper!.isDetecting,
            controller: controller!,
            selectPrompt: StringConstant.selectImage,
            onSelect: helper!.pickImage,
            onDetect: helper!.detectText,
            onClearImage: helper!.clearImage,
            detectionRenderer: (results) {
              final result = results.first;
              return SelectableText.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '${StringConstant.extractedText}:\n',
                      style: const TextStyle(
                        fontSize: Dimens.textMedium,
                        fontWeight: FontWeight.bold,
                        color: AppColorConstant.appBlack,
                      ),
                    ),
                    TextSpan(
                      text: result.textExtractionResult,
                      style: const TextStyle(
                        fontSize: Dimens.textMedium,
                        color: AppColorConstant.appBlack,
                      ),
                    ),
                    if (result.detectedLanguages != null && result.detectedLanguages!.isNotEmpty) ...[
                      TextSpan(
                        text: '\n\n${StringConstant.detectedLanguage}:\n',
                        style: const TextStyle(
                          fontSize: Dimens.textMedium,
                          fontWeight: FontWeight.bold,
                          color: AppColorConstant.appBlack,
                        ),
                      ),
                      TextSpan(
                        text: result.detectedLanguages!.join('\n'),
                        style: const TextStyle(
                          fontSize: Dimens.textMedium,
                          color: AppColorConstant.appBlack,
                        ),
                      ),
                    ],
                  ],
                ),
              );
            },
          );
        });
  }
}
