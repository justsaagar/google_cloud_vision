import 'package:google_cloud_vision/serialized/message_model.dart';
import 'package:google_vision/google_vision.dart';
import 'package:json_annotation/json_annotation.dart';

part 'face_detection_result_model.g.dart';

@JsonSerializable()
class FaceDetectionResult implements DetectionResult {
  @JsonKey(name: 'data')
  final FaceAnnotation data;

  FaceDetectionResult({required this.data});

  factory FaceDetectionResult.fromJson(Map<String, dynamic> json) => _$FaceDetectionResultFromJson(json);

  Map<String, dynamic> toJson() => _$FaceDetectionResultToJson(this);
}