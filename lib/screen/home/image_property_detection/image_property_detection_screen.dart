import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_cloud_vision/app/constant/color_constant.dart';
import 'package:google_cloud_vision/app/constant/string_constant.dart';
import 'package:google_cloud_vision/app/utills/dimension.dart';
import 'package:google_cloud_vision/controller/image_property_detection_controller.dart';
import 'package:google_cloud_vision/app/widgets/chat_view.dart';
import 'package:google_cloud_vision/screen/home/image_property_detection/image_property_detection_helper.dart';
import 'package:google_cloud_vision/serialized/image_property_result_model.dart';
import 'package:google_cloud_vision/serialized/message_model.dart';

class ImagePropertyDetectionScreen extends StatefulWidget {
  const ImagePropertyDetectionScreen({super.key});

  @override
  State<ImagePropertyDetectionScreen> createState() => ImagePropertyDetectionScreenState();
}

class ImagePropertyDetectionScreenState extends State<ImagePropertyDetectionScreen> {
  ImagePropertyDetectionScreenHelper? helper;
  ImagePropertyDetectionController? controller;

  @override
  Widget build(BuildContext context) {
    helper ??= ImagePropertyDetectionScreenHelper(this);
    return GetBuilder(
        init: ImagePropertyDetectionController(),
        builder: (ImagePropertyDetectionController imagePropertyDetectionController) {
          controller = imagePropertyDetectionController;
          return ChatScreen<ImagePropertyResult, ImagePropertyDetectionController>(
            title: StringConstant.imagePropertyDetection,
            messages: helper!.messages.cast<MessageModel<ImagePropertyResult>>(),
            image: helper!.image,
            isDetecting: helper!.isDetecting,
            controller: controller!,
            selectPrompt: StringConstant.selectImage,
            onSelect: helper!.pickImage,
            onDetect: helper!.detectProperties,
            onClearImage: helper!.clearImage,
            detectionRenderer: (results) {
              return SelectableText.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '${StringConstant.dominantColors}:\n',
                      style: const TextStyle(
                        fontSize: Dimens.textMedium,
                        fontWeight: FontWeight.bold,
                        color: AppColorConstant.appBlack,
                      ),
                    ),
                    ...results.asMap().entries.map((entry) {
                      final color = entry.value.data.color;
                      return TextSpan(
                        children: [
                          WidgetSpan(
                            child: Container(
                              width: Dimens.widthMedium,
                              height: Dimens.heightSmall,
                              margin: const EdgeInsets.only(right: DimensPadding.paddingSmall),
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(
                                  color.red.toInt(),
                                  color.green.toInt(),
                                  color.blue.toInt(),
                                  1,
                                ),
                                borderRadius: BorderRadius.circular(Dimens.borderRadiusRegular),
                              ),
                            ),
                          ),
                          TextSpan(
                            text: 'RGB: (${color.red.toInt()}, ${color.green.toInt()}, ${color.blue.toInt()}), Fraction: ${entry.value.data.pixelFraction.toStringAsFixed(2)}${entry.key < results.length - 1 ? '\n' : ''}',
                            style: const TextStyle(
                              fontSize: Dimens.textMedium,
                              color: AppColorConstant.appBlack,
                            ),
                          ),
                        ],
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
