import 'package:flutter/material.dart';
import 'package:google_cloud_vision/app/constant/color_constant.dart';
import 'package:google_cloud_vision/app/utills/dimension.dart';
import 'package:google_cloud_vision/app/widgets/app_app_bar.dart';
import 'package:google_cloud_vision/app/widgets/app_image_assets.dart';
import 'package:google_cloud_vision/app/widgets/app_text.dart';
import 'package:google_cloud_vision/screen/home/home_screen_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  HomeScreenHelper? helper;

  @override
  Widget build(BuildContext context) {
    helper ??= HomeScreenHelper(this);

    return Scaffold(
      backgroundColor: AppColorConstant.appWhite,
      appBar: AppAppBar(appbarTitle: 'Google Cloud Vision Features',showBackButton: false),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Two columns
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: helper?.detectionList.length,
          itemBuilder: (context, index) {
            final feature = helper?.detectionList[index];
            return Card(
              color: AppColorConstant.appWhite,
              elevation: 4,
              child: InkWell(
                onTap: feature?.onTap,
                child: Padding(
                  padding: const EdgeInsets.all(DimensPadding.paddingSmall),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppImageAsset(image: feature?.image ?? '', height: Dimens.heightMedium),
                      AppText(
                        feature?.title ?? '',
                        fontSize: Dimens.textExtraMedium,
                        fontWeight: FontWeight.bold,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: Dimens.heightExtraSmall),
                      AppText(
                        feature?.description ?? '',
                        fontSize: Dimens.textMedium,
                        color: AppColorConstant.appGrey,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
