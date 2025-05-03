import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:google_cloud_vision/app/helper/extension_helper.dart';
import 'package:google_cloud_vision/app/utills/app_utills.dart';
import 'package:google_cloud_vision/repository/web_detection_repository/web_detection_repository.dart';
import 'package:google_cloud_vision/serialized/web_detection_result_model.dart';
import 'package:google_vision/google_vision.dart';

class WebDetectionRepositoryImpl implements WebDetectionRepository {
  @override
  Future<List<WebDetectionResult>> detectWeb(Uint8List imageBytes) async {
    try {
      final byteBuffer = imageBytes.buffer;
      final googleVision = await getGoogleVision(Get.context!);

      final webDetection = await googleVision.image.webDetection(
        JsonImage.fromBuffer(byteBuffer),
      );

      final webResult = {
        'bestGuessLabels': webDetection?.bestGuessLabels?.map((label) => {'label': label.label}).toList() ?? [],
        'pagesWithMatchingImages': webDetection?.pagesWithMatchingImages?.map((page) => {'url': page.url}).toList() ?? [],
        'visuallySimilarImages': webDetection?.visuallySimilarImages?.map((image) => {'url': image.url}).toList() ?? [],
        'webEntities': webDetection?.webEntities
                ?.map((entity) => {
                      'description': entity.description,
                      'score': entity.score,
                    })
                .toList() ??
            [],
      };

      return [WebDetectionResult(data: webResult)];
    } catch (e) {
      '$e'.logs();
      throw Exception('Error performing web detection: $e');
    }
  }
}
