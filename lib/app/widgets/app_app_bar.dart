import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_cloud_vision/app/constant/color_constant.dart';
import 'package:google_cloud_vision/app/widgets/app_text.dart';

class AppAppBar extends PreferredSize {
  final double? height;
  final String appbarTitle;
  final String? fontFamily;
  final GestureTapCallback? onTapBack;
  final Color? backGroundColor;
  final bool? showBackButton;

  AppAppBar({
    super.key,
    this.height,
    this.appbarTitle = '',
    this.onTapBack,
    this.fontFamily,
    this.backGroundColor,
    this.showBackButton = true,
  }) : super(preferredSize: Size.fromHeight(height ?? 160), child: const SizedBox());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: height,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: backGroundColor ?? AppColorConstant.appWhite,
            ),
            child: Row(
              children: [
                if (showBackButton == true) IconButton(onPressed: () => Get.back(), icon: Icon(Icons.arrow_back_ios_new_outlined, color: AppColorConstant.appBlack)),
                if (appbarTitle.isNotEmpty)
                  Expanded(
                    child: AppText(
                      appbarTitle.tr,
                      color: AppColorConstant.appBlack,
                      fontSize: 20,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w600,
                      fontFamily: fontFamily,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                if (showBackButton == true) SizedBox(width: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
