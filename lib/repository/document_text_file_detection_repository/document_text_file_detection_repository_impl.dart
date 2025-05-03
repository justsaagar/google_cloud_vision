import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:google_cloud_vision/app/helper/extension_helper.dart';
import 'package:google_cloud_vision/app/utills/app_utills.dart';
import 'package:google_cloud_vision/repository/document_text_file_detection_repository/document_text_file_detection_repository.dart';
import 'package:google_cloud_vision/serialized/text_detection_result_model.dart';
import 'package:google_vision/google_vision.dart';

class DocumentTextFileDetectionRepositoryImpl implements DocumentTextFileDetectionRepository {
  @override
  Future<TextDetectionResult> detectTextFromFile(Uint8List fileBytes) async {
    try {
      final byteBuffer = fileBytes.buffer;
      final googleVision = await getGoogleVision(Get.context!);

      final List<AnnotateFileResponse> annotateFileResponses = await googleVision.file.documentTextDetection(
        InputConfig.fromBuffer(byteBuffer),
      );

      StringBuffer output = StringBuffer();
      List<String> detectedLanguages = [];

      for (var annotateFileResponse in annotateFileResponses) {
        if (annotateFileResponse.error != null) {
          output.writeln('Error: ${annotateFileResponse.error!.message}');
          'Error in AnnotateFileResponse: ${annotateFileResponse.error!.message}'.logs();
          continue;
        }

        int totalPages = annotateFileResponse.totalPages;
        output.writeln('Total Pages: $totalPages\n');

        for (var pageIndex = 0; pageIndex < (annotateFileResponse.responses?.length ?? 0); pageIndex++) {
          var annotateImageResponse = annotateFileResponse.responses![pageIndex];

          if (annotateImageResponse.fullTextAnnotation == null) {
            output.writeln('No text found for page ${pageIndex + 1}.');
            continue;
          }

          output.writeln('=== Page ${pageIndex + 1} ===');

          var page = annotateImageResponse.fullTextAnnotation!.pages.first;

          if (page.property?.detectedLanguages != null) {
            for (var lang in page.property!.detectedLanguages!) {
              String languageInfo = '${lang.languageCode} (Confidence: ${lang.confidence})';
              if (!detectedLanguages.contains(languageInfo)) {
                detectedLanguages.add(languageInfo);
              }
            }
          }

          page.blocks?.forEach((block) {
            block.paragraphs?.forEach((paragraph) {
              output.writeln();
              paragraph.words?.forEach((word) {
                var segment = word.symbols?.map((e) => e.text).join();
                output.write('${segment ?? ''} ');
              });
            });
          });

          output.writeln('\n');
        }
      }

      return TextDetectionResult(
        textExtractionResult: output.toString(),
        detectedLanguages: detectedLanguages,
      );
    } catch (e) {
      '$e'.logs();
      throw Exception('Error processing file: $e');
    }
  }
}
