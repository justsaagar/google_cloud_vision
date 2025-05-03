import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:google_cloud_vision/app/helper/extension_helper.dart';
import 'package:google_cloud_vision/app/utills/app_utills.dart';
import 'package:google_cloud_vision/repository/image_property_detection_repository/image_property_detection_repository.dart';
import 'package:google_cloud_vision/serialized/image_property_result_model.dart';
import 'package:google_vision/google_vision.dart';

class ImagePropertyDetectionRepositoryImpl implements ImagePropertyDetectionRepository {
  @override
  Future<List<ImagePropertyResult>> detectProperties(Uint8List imageBytes) async {
    try {
      final byteBuffer = imageBytes.buffer;
      final googleVision = await getGoogleVision(Get.context!);

      final imageProperties = await googleVision.image.imageProperties(
        JsonImage.fromBuffer(byteBuffer),
      );

      return imageProperties?.dominantColors.colors.map((e) => ImagePropertyResult(data: e)).toList() ?? [];
    } catch (e) {
      '$e'.logs();
      throw Exception('Error detecting dominant colors: $e');
    }
  }
}
