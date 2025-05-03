import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_cloud_vision/app/constant/color_constant.dart';

class AppText extends StatelessWidget {
  final String title;
  final Color? color;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final double? fontSize;
  final TextAlign? textAlign;
  final double? height;
  final FontStyle? fontStyle;
  final TextOverflow? overflow;
  final int? maxLines;
  final TextDecoration? decoration;
  final double? letterSpacing;
  final double? leftSpacing;

  const AppText(
    this.title, {
    super.key,
    this.color,
    this.fontWeight,
    this.fontFamily,
    this.fontSize,
    this.textAlign,
    this.height,
    this.fontStyle,
    this.maxLines,
    this.overflow,
    this.decoration = TextDecoration.none,
    this.letterSpacing,
    this.leftSpacing,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: leftSpacing ?? 0),
      child: Text(
        title.tr,
        textAlign: textAlign,
        maxLines: maxLines,
        style: TextStyle(
          color: color,
          fontWeight: fontWeight,
          fontSize: fontSize ?? 16,
          height: height,
          fontStyle: fontStyle,
          fontFamily: fontFamily,
          overflow: overflow,
          decoration: decoration,
          decorationColor: AppColorConstant.appGrey.withValues(alpha: 0.5),
          letterSpacing: letterSpacing,
        ),
      ),
    );
  }
}
