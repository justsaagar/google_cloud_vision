import 'dart:ui';

class DetectionModel {
  final String title;
  final String image;
  final VoidCallback onTap;
  final String description;

  DetectionModel({
    required this.title,
    required this.image,
    required this.onTap,
    required this.description,
  });
}
