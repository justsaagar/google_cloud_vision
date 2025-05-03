import 'package:google_cloud_vision/serialized/message_model.dart';
import 'package:google_vision/google_vision.dart';
import 'package:json_annotation/json_annotation.dart';

part 'image_property_result_model.g.dart';

@JsonSerializable()
class ImagePropertyResult implements DetectionResult {
  @JsonKey(name: 'data')
  final ColorInfo data;

  ImagePropertyResult({required this.data});

  factory ImagePropertyResult.fromJson(Map<String, dynamic> json) => _$ImagePropertyResultFromJson(json);

  Map<String, dynamic> toJson() => _$ImagePropertyResultToJson(this);
}
