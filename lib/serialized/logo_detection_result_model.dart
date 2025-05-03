import 'package:google_cloud_vision/serialized/message_model.dart';
import 'package:google_vision/google_vision.dart';
import 'package:json_annotation/json_annotation.dart';

part 'logo_detection_result_model.g.dart';

@JsonSerializable()
class LogoDetectionResult implements DetectionResult {
  @JsonKey(name: 'data')
  final EntityAnnotation data;

  LogoDetectionResult({required this.data});

  factory LogoDetectionResult.fromJson(Map<String, dynamic> json) => _$LogoDetectionResultFromJson(json);

  Map<String, dynamic> toJson() => _$LogoDetectionResultToJson(this);
}