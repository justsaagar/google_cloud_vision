import 'package:flutter/material.dart';
import 'package:google_cloud_vision/app/constant/app_asset.dart';
import 'package:google_cloud_vision/app/constant/color_constant.dart';
import 'package:google_cloud_vision/app/helper/app_enum.dart';
import 'package:google_cloud_vision/app/utills/dimension.dart';
import 'package:google_cloud_vision/app/widgets/app_image_assets.dart';
import 'package:google_cloud_vision/app/widgets/app_text.dart';
import 'package:google_cloud_vision/serialized/message_model.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ChatMessage<T extends DetectionResult> extends StatelessWidget {
  final MessageModel<T> message;
  final Widget Function(List<T>)? detectionRenderer;

  const ChatMessage({
    super.key,
    required this.message,
    this.detectionRenderer,
  });

  @override
  Widget build(BuildContext context) {
    final isUser = message.isUser;
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: DimensPadding.paddingSmall),
        padding: const EdgeInsets.all(DimensPadding.paddingNormal),
        decoration: BoxDecoration(
          color: isUser ? AppColorConstant.appWhite200 : AppColorConstant.appGrey.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(Dimens.borderRadiusRegular),
        ),
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    switch (message.messageType) {
      case MessageType.image:
        return AppImageAsset(
          isFile: true,
          image: message.content,
          fit: BoxFit.contain,
          width: 200,
        );
      case MessageType.file:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppImageAsset(
              image: AppAsset.pdf,
              fit: BoxFit.contain,
              width: 40,
            ),
            SizedBox(width: Dimens.widthMedium),
            AppText(
              message.content,
              fontSize: Dimens.textMedium,
            ),
          ],
        );
      case MessageType.detection:
        return detectionRenderer != null && message.detectionResults != null
            ? detectionRenderer!(message.detectionResults!)
            : const AppText('No detection results.');
      case MessageType.loading:
        return LoadingAnimationWidget.progressiveDots(
          color: AppColorConstant.appBlack,
          size: 40,
        );
      case MessageType.text:
      default:
        return AppText(
          message.content,
          color: message.isUser ? AppColorConstant.appWhite : AppColorConstant.appBlack,
          fontSize: Dimens.textMedium,
        );
    }
  }
}