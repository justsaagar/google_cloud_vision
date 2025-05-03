import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:google_cloud_vision/app/constant/string_constant.dart';
import 'package:google_cloud_vision/app/helper/extension_helper.dart';
import 'package:google_cloud_vision/app/utills/app_utills.dart';
import 'package:google_cloud_vision/repository/document_text_detection_repository/document_text_detection_repository.dart';
import 'package:google_cloud_vision/serialized/text_detection_result_model.dart';
import 'package:google_vision/google_vision.dart';

class DocumentTextDetectionRepositoryImpl implements DocumentTextDetectionRepository {
  @override
  Future<TextDetectionResult> detectText(Uint8List imageBytes) async {
    try {
      final byteBuffer = imageBytes.buffer;
      final googleVision = await getGoogleVision(Get.context!);

      final entityAnnotations = await googleVision.image.documentTextDetection(
        JsonImage.fromBuffer(byteBuffer),
      );

      String extractedText = '';
      List<String> detectedLanguages = [];

      if (entityAnnotations != null) {
        extractedText = entityAnnotations.text;

        for (var page in entityAnnotations.pages) {
          if (page.property?.detectedLanguages != null) {
            for (var lang in page.property!.detectedLanguages!) {
              String languageInfo = '${lang.languageCode} (Confidence: ${lang.confidence})';
              if (!detectedLanguages.contains(languageInfo)) {
                detectedLanguages.add(languageInfo);
              }
            }
          }
          for (var block in page.blocks!) {
            for (var paragraph in block.paragraphs!) {
              String paragraphText = paragraph.words!.map((word) => word.symbols!.map((s) => s.text).join('')).join(' ');
              extractedText += '\n$paragraphText';
            }
          }
        }
      } else {
        extractedText = StringConstant.noTextDetect;
      }

      return TextDetectionResult(
        textExtractionResult: extractedText,
        detectedLanguages: detectedLanguages,
      );
    } catch (e) {
      '$e'.logs();
      throw Exception('Error detecting text: $e');
    }
  }
}
