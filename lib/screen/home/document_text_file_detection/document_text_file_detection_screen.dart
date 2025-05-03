import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_cloud_vision/app/constant/color_constant.dart';
import 'package:google_cloud_vision/app/constant/string_constant.dart';
import 'package:google_cloud_vision/app/utills/dimension.dart';
import 'package:google_cloud_vision/controller/document_text_file_detection_controller.dart';
import 'package:google_cloud_vision/app/widgets/chat_view.dart';
import 'package:google_cloud_vision/screen/home/document_text_file_detection/document_text_file_detection_helper.dart';
import 'package:google_cloud_vision/serialized/message_model.dart';
import 'package:google_cloud_vision/serialized/text_detection_result_model.dart';

class DocumentTextFileDetectionScreen extends StatefulWidget {
  const DocumentTextFileDetectionScreen({super.key});

  @override
  State<DocumentTextFileDetectionScreen> createState() => DocumentTextFileDetectionScreenState();
}

class DocumentTextFileDetectionScreenState extends State<DocumentTextFileDetectionScreen> {
  DocumentTextFileDetectionScreenHelper? helper;
  DocumentTextFileDetectionController? controller;

  @override
  Widget build(BuildContext context) {
    helper ??= DocumentTextFileDetectionScreenHelper(this);
    return GetBuilder(
      init: DocumentTextFileDetectionController(),
      builder: (DocumentTextFileDetectionController documentTextFileDetectionController) {
        controller = documentTextFileDetectionController;
        return ChatScreen<TextDetectionResult, DocumentTextFileDetectionController>(
          title: StringConstant.documentTextFile,
          messages: helper!.messages.cast<MessageModel<TextDetectionResult>>(),
          controller: controller!,
          selectPrompt: StringConstant.uploadPdfFile,
          onSelect: () => helper!.pickAndProcessFile(context),
          detectionRenderer: (results) {
            final result = results.first;
            return SelectableText.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '${StringConstant.extractedText}:\n',
                    style: TextStyle(
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
                ],
              ),
            );
          },
        );
      }
    );
  }
}