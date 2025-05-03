import 'package:google_cloud_vision/serialized/message_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'web_detection_result_model.g.dart';

@JsonSerializable()
class WebDetectionResult implements DetectionResult {
  @JsonKey(name: 'data')
  final Map<String, dynamic> data;

  WebDetectionResult({required this.data});

  factory WebDetectionResult.fromJson(Map<String, dynamic> json) => _$WebDetectionResultFromJson(json);

  Map<String, dynamic> toJson() => _$WebDetectionResultToJson(this);
}
