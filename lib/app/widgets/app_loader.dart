import 'package:flutter/material.dart';
import 'package:google_cloud_vision/app/constant/color_constant.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: AppColorConstant.appWhite.withValues(alpha: 0.6),
      ),
      child: LoadingAnimationWidget.beat(color: AppColorConstant.appBlack.withValues(alpha: 0.7), size: 40),
    );
  }
}
