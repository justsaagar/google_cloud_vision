import 'package:google_cloud_vision/serialized/message_model.dart';
import 'package:google_vision/google_vision.dart';
import 'package:json_annotation/json_annotation.dart';

part 'object_detection_result_model.g.dart';

@JsonSerializable()
class ObjectDetectionResult implements DetectionResult {
  @JsonKey(name: 'data')
  final LocalizedObjectAnnotation data;

  ObjectDetectionResult({required this.data});

  factory ObjectDetectionResult.fromJson(Map<String, dynamic> json) => _$ObjectDetectionResultFromJson(json);

  Map<String, dynamic> toJson() => _$ObjectDetectionResultToJson(this);
}