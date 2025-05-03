import 'package:google_cloud_vision/app/helper/app_enum.dart';
import 'package:json_annotation/json_annotation.dart';

part 'message_model.g.dart';

abstract class DetectionResult {}

@JsonSerializable(genericArgumentFactories: true)
class MessageModel<T extends DetectionResult> {
  @JsonKey(name: 'is_user')
  final bool isUser;

  @JsonKey(name: 'message_type')
  final MessageType messageType;

  @JsonKey(name: 'content', defaultValue: '')
  final String content;

  @JsonKey(name: 'detection_type')
  final DetectionType? detectionType;

  @JsonKey(name: 'detection_results')
  final List<T>? detectionResults;

  MessageModel({
    required this.isUser,
    required this.messageType,
    this.content = '',
    this.detectionType,
    this.detectionResults,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT) => _$MessageModelFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) => _$MessageModelToJson(this, toJsonT);
}
