import 'package:google_cloud_vision/serialized/message_model.dart';
import 'package:google_vision/google_vision.dart';
import 'package:json_annotation/json_annotation.dart';

part 'label_detection_result_model.g.dart';

@JsonSerializable()
class LabelDetectionResult implements DetectionResult {
  @JsonKey(name: 'data')
  final EntityAnnotation data;

  LabelDetectionResult({required this.data});

  factory LabelDetectionResult.fromJson(Map<String, dynamic> json) => _$LabelDetectionResultFromJson(json);

  Map<String, dynamic> toJson() => _$LabelDetectionResultToJson(this);
}