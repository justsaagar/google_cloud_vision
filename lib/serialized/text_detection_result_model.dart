import 'package:google_cloud_vision/serialized/message_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'text_detection_result_model.g.dart';

@JsonSerializable()
class TextDetectionResult implements DetectionResult {
  @JsonKey(name: 'text_extraction_result')
  final String textExtractionResult;

  @JsonKey(name: 'detected_languages')
  final List<String>? detectedLanguages;

  TextDetectionResult({
    required this.textExtractionResult,
    this.detectedLanguages,
  });

  factory TextDetectionResult.fromJson(Map<String, dynamic> json) => _$TextDetectionResultFromJson(json);

  Map<String, dynamic> toJson() => _$TextDetectionResultToJson(this);
}