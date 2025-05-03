import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_cloud_vision/app/constant/color_constant.dart';
import 'package:google_cloud_vision/app/constant/string_constant.dart';
import 'package:google_cloud_vision/app/utills/dimension.dart';
import 'package:google_cloud_vision/app/widgets/app_text.dart';
import 'package:google_cloud_vision/controller/face_detection_controller.dart';
import 'package:google_cloud_vision/app/widgets/chat_view.dart';
import 'package:google_cloud_vision/screen/home/face_detection/face_detection_helper.dart';
import 'package:google_cloud_vision/serialized/face_detection_result_model.dart';
import 'package:google_cloud_vision/serialized/message_model.dart';

class FaceDetectionScreen extends StatefulWidget {
  const FaceDetectionScreen({super.key});

  @override
  State<FaceDetectionScreen> createState() => FaceDetectionScreenState();
}

class FaceDetectionScreenState extends State<FaceDetectionScreen> {
  FaceDetectionHelper? helper;
  FaceDetectionController? controller;

  @override
  Widget build(BuildContext context) {
    helper ??= FaceDetectionHelper(this);
    return GetBuilder(
        init: FaceDetectionController(),
        builder: (FaceDetectionController faceDetectionController) {
          controller = faceDetectionController;
          return ChatScreen<FaceDetectionResult, FaceDetectionController>(
            title: StringConstant.faceDetection,
            messages: helper!.messages.cast<MessageModel<FaceDetectionResult>>(),
            image: helper!.image,
            isDetecting: helper!.isDetecting,
            controller: controller!,
            selectPrompt: StringConstant.selectImage,
            onSelect: helper!.pickImage,
            onDetect: helper!.detectFaces,
            onClearImage: helper!.clearImage,
            detectionRenderer: (results) {
              if (results.isEmpty) {
                return const AppText(
                  'No faces detected.',
                  fontSize: Dimens.textMedium,
                  color: AppColorConstant.appBlack,
                );
              }
              return SelectableText.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '${StringConstant.detectedFaces}:\n',
                      style: const TextStyle(
                        fontSize: Dimens.textMedium,
                        fontWeight: FontWeight.bold,
                        color: AppColorConstant.appBlack,
                      ),
                    ),
                    ...results.asMap().entries.expand((entry) {
                      final index = entry.key;
                      final face = entry.value.data;
                      final fields = [
                        ('Confidence', () => '${(face.detectionConfidence * 100).toStringAsFixed(2)}%'),
                        ('Joy Likelihood', () => face.enumJoyLikelihood.toString()),
                        ('Sorrow Likelihood', () => face.enumSorrowLikelihood.toString()),
                        ('Anger Likelihood', () => face.enumAngerLikelihood.toString()),
                        ('Surprise Likelihood', () => face.enumSurpriseLikelihood.toString()),
                        ('Under Exposed Likelihood', () => face.enumUnderExposedLikelihood.toString()),
                        ('Blurred Likelihood', () => face.enumBlurredLikelihood.toString()),
                        ('Headwear Likelihood', () => face.enumHeadwearLikelihood.toString()),
                        ('Bounding Poly', () => face.boundingPoly.vertices.map((v) => '(${v.x}, ${v.y})').join(', ')),
                        ('FD Bounding Poly', () => face.fdBoundingPoly.vertices.map((v) => '(${v.x}, ${v.y})').join(', ')),
                      ];
                      return [
                        TextSpan(
                          text: 'Face ${index + 1}:\n',
                          style: const TextStyle(
                            fontSize: Dimens.textMedium,
                            fontWeight: FontWeight.bold,
                            color: AppColorConstant.appBlack,
                          ),
                        ),
                        ...fields.map((field) => TextSpan(
                              text: '${field.$1}: ${field.$2()}\n',
                              style: const TextStyle(
                                fontSize: Dimens.textMedium,
                                color: AppColorConstant.appBlack,
                              ),
                            )),
                        if (index < results.length - 1)
                          const TextSpan(
                            text: '\n',
                            style: TextStyle(
                              fontSize: Dimens.textMedium,
                              color: AppColorConstant.appBlack,
                            ),
                          ),
                      ];
                    }),
                  ],
                ),
              );
            },
          );
        });
  }
}
