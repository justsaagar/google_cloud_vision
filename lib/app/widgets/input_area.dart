import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_cloud_vision/app/constant/color_constant.dart';
import 'package:google_cloud_vision/app/utills/dimension.dart';
import 'package:google_cloud_vision/app/widgets/app_image_assets.dart';
import 'package:google_cloud_vision/app/widgets/app_text.dart';

class InputArea extends StatelessWidget {
  final File? image;
  final bool isDetecting;
  final String selectPrompt;
  final VoidCallback? onSelect;
  final VoidCallback? onDetect;
  final VoidCallback? onClearImage;

  const InputArea({
    super.key,
    this.image,
    this.isDetecting = false,
    required this.selectPrompt,
    this.onSelect,
    this.onDetect,
    this.onClearImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(DimensPadding.paddingNormal),
      color: AppColorConstant.appWhite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (image != null)
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimens.borderRadiusRegular),
                    border: Border.all(color: AppColorConstant.appBlack),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(Dimens.borderRadiusRegular),
                    child: AppImageAsset(
                      isFile: true,
                      image: image!.path,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: -10,
                  right: -10,
                  child: GestureDetector(
                    onTap: onClearImage,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppColorConstant.appWhite,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColorConstant.appBlack),
                      ),
                      child: const Icon(
                        Icons.close,
                        size: 16,
                        color: AppColorConstant.appBlack,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          SizedBox(height: Dimens.heightSmall),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: onSelect,
                  child: DottedBorder(
                    color: AppColorConstant.appGrey.withValues(alpha: 0.5),
                    strokeWidth: 1,
                    dashPattern: const [6, 3],
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(Dimens.borderRadiusRegular),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: DimensPadding.paddingSmall,
                        horizontal: DimensPadding.paddingNormal,
                      ),
                      alignment: Alignment.center,
                      child: AppText(
                        selectPrompt,
                        fontSize: Dimens.textMedium,
                        color: AppColorConstant.appGrey,
                      ),
                    ),
                  ),
                ),
              ),
              if (onDetect != null) ...[
                const SizedBox(width: Dimens.widthMedium),
                InkWell(
                  onTap: onDetect,
                  child: Container(
                    padding: const EdgeInsets.all(DimensPadding.paddingSmall),
                    decoration: BoxDecoration(
                      color: (image != null && !isDetecting) ? AppColorConstant.appBlack : AppColorConstant.appGrey,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.upload,
                      color: AppColorConstant.appWhite,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}