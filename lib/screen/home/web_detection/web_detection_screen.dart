import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_cloud_vision/app/constant/color_constant.dart';
import 'package:google_cloud_vision/app/constant/string_constant.dart';
import 'package:google_cloud_vision/app/utills/dimension.dart';
import 'package:google_cloud_vision/app/widgets/app_text.dart';
import 'package:google_cloud_vision/app/widgets/chat_view.dart';
import 'package:google_cloud_vision/controller/web_detection_controller.dart';
import 'package:google_cloud_vision/screen/home/web_detection/web_detection_helper.dart';
import 'package:google_cloud_vision/serialized/message_model.dart';
import 'package:google_cloud_vision/serialized/web_detection_result_model.dart';

class WebDetectionScreen extends StatefulWidget {
  const WebDetectionScreen({super.key});

  @override
  State<WebDetectionScreen> createState() => WebDetectionScreenState();
}

class WebDetectionScreenState extends State<WebDetectionScreen> {
  WebDetectionHelper? helper;
  WebDetectionController? controller;

  @override
  Widget build(BuildContext context) {
    helper ??= WebDetectionHelper(this);
    return GetBuilder(
        init: WebDetectionController(),
        builder: (WebDetectionController webDetectionController) {
          controller = webDetectionController;
          return ChatScreen<WebDetectionResult, WebDetectionController>(
            title: StringConstant.webDetection,
            messages: helper!.messages.cast<MessageModel<WebDetectionResult>>(),
            image: helper!.image,
            isDetecting: helper!.isDetecting,
            controller: controller!,
            selectPrompt: StringConstant.selectImage,
            onSelect: helper!.pickImage,
            onDetect: helper!.detectWeb,
            onClearImage: helper!.clearImage,
            detectionRenderer: (results) {
              if (results.isEmpty) {
                return const AppText(
                  'No web detection results.',
                  fontSize: Dimens.textMedium,
                  color: AppColorConstant.appBlack,
                );
              }
              final result = results.first.data;
              return SelectableText.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '${StringConstant.webDetectionDescription}:\n',
                      style: const TextStyle(
                        fontSize: Dimens.textMedium,
                        fontWeight: FontWeight.bold,
                        color: AppColorConstant.appBlack,
                      ),
                    ),
                    if (result['bestGuessLabels'] != null) ...[
                      ...result['bestGuessLabels'].asMap().entries.map((entry) => TextSpan(
                            text: 'Best Guess Label: ${entry.value['label']}\n',
                            style: const TextStyle(
                              fontSize: Dimens.textMedium,
                              color: AppColorConstant.appBlack,
                            ),
                          )),
                      WidgetSpan(
                        child: SizedBox(height: Dimens.heightMedium),
                      ),
                    ],
                    if (result['pagesWithMatchingImages'] != null) ...[
                      ...result['pagesWithMatchingImages'].asMap().entries.expand((entry) => [
                            TextSpan(
                              text: 'Matching Page: ',
                              style: const TextStyle(
                                fontSize: Dimens.textMedium,
                                color: AppColorConstant.appBlack,
                              ),
                            ),
                            TextSpan(
                              text: '${entry.value['url']}\n',
                              style: const TextStyle(
                                fontSize: Dimens.textMedium,
                                color: AppColorConstant.appBlue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            if (entry.key < result['pagesWithMatchingImages'].length - 1)
                              WidgetSpan(
                                child: SizedBox(height: Dimens.heightMedium),
                              ),
                          ]),
                      WidgetSpan(
                        child: SizedBox(height: Dimens.heightLarge),
                      ),
                    ],
                    if (result['visuallySimilarImages'] != null) ...[
                      ...result['visuallySimilarImages'].asMap().entries.expand((entry) => [
                            TextSpan(
                              text: 'Similar Image: ',
                              style: const TextStyle(
                                fontSize: Dimens.textMedium,
                                color: AppColorConstant.appBlack,
                              ),
                            ),
                            TextSpan(
                              text: '${entry.value['url']}\n',
                              style: const TextStyle(
                                fontSize: Dimens.textMedium,
                                color: AppColorConstant.appBlue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            if (entry.key < result['visuallySimilarImages'].length - 1)
                              WidgetSpan(
                                child: SizedBox(height: Dimens.heightMedium),
                              ),
                          ]),
                      WidgetSpan(
                        child: SizedBox(height: Dimens.heightMedium),
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
