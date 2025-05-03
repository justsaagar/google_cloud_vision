import 'package:google_cloud_vision/serialized/message_model.dart';
import 'package:google_vision/google_vision.dart';
import 'package:json_annotation/json_annotation.dart';

part 'landmark_detection_result_model.g.dart';

@JsonSerializable()
class LandmarkDetectionResult implements DetectionResult {
  @JsonKey(name: 'data')
  final EntityAnnotation data;

  LandmarkDetectionResult({required this.data});

  factory LandmarkDetectionResult.fromJson(Map<String, dynamic> json) => _$LandmarkDetectionResultFromJson(json);

  Map<String, dynamic> toJson() => _$LandmarkDetectionResultToJson(this);
}