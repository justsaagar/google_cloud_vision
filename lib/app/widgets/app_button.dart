import 'package:flutter/material.dart';
import 'package:google_cloud_vision/app/constant/color_constant.dart';

import 'app_text.dart';

class AppButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final double? fontSize;
  final Color? color;
  final Color? backgroundColor;
  final Color? borderColor;

  final FontWeight? fontWeight;
  final double? vertical;
  final double? horizontal;
  final double? letterSpacing;
  final double? borderRadius;
  final BorderRadiusGeometry? borderRadiusCustom;
  final EdgeInsetsGeometry? margin;

  const AppButton({
    super.key,
    required this.title,
    this.fontSize,
    required this.onPressed,
    this.fontWeight,
    this.color,
    this.vertical,
    this.horizontal,
    this.borderColor,
    this.backgroundColor,
    this.letterSpacing,
    this.borderRadius,
    this.borderRadiusCustom,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: null,
        margin: margin ?? EdgeInsets.zero,
        padding: EdgeInsets.symmetric(horizontal: horizontal ?? 12, vertical: vertical ?? 10),
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColorConstant.appBlack,
          borderRadius: borderRadiusCustom ?? BorderRadius.circular(borderRadius ?? 12),
        ),
        child: AppText(
          title,
          color: color ?? AppColorConstant.appWhite,
          fontWeight: fontWeight ?? FontWeight.w600,
          fontSize: fontSize ?? 18,
          letterSpacing: letterSpacing,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
