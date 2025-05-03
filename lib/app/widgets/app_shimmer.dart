import 'package:flutter/material.dart';
import 'package:google_cloud_vision/app/constant/color_constant.dart';
import 'package:shimmer/shimmer.dart';

class AppShimmerEffectView extends StatelessWidget {
  final double? height;
  final double? width;
  final double? borderRadius;

  const AppShimmerEffectView({super.key, this.height, this.width, this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColorConstant.appWhite200,
      highlightColor: AppColorConstant.appWhite100,
      child: Container(
        height: height ?? 30,
        width: width ?? 50,
        decoration: BoxDecoration(
          color: AppColorConstant.appWhite200,
          borderRadius: BorderRadius.circular(borderRadius ?? 4),
        ),
      ),
    );
  }
}
