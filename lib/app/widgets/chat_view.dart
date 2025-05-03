import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_cloud_vision/app/constant/color_constant.dart';
import 'package:google_cloud_vision/app/utills/dimension.dart';
import 'package:google_cloud_vision/app/widgets/app_app_bar.dart';
import 'package:google_cloud_vision/app/widgets/chat_messages.dart';
import 'package:google_cloud_vision/app/widgets/input_area.dart';
import 'package:google_cloud_vision/serialized/message_model.dart';

class ChatScreen<T extends DetectionResult, C extends GetxController> extends StatelessWidget {
  final String title;
  final List<MessageModel<T>> messages;
  final File? image;
  final bool isDetecting;
  final C controller;
  final String selectPrompt;
  final Widget Function(List<T>)? detectionRenderer;
  final VoidCallback? onSelect;
  final VoidCallback? onDetect;
  final VoidCallback? onClearImage;

  const ChatScreen({
    super.key,
    required this.title,
    required this.messages,
    this.image,
    this.isDetecting = false,
    required this.controller,
    required this.selectPrompt,
    this.detectionRenderer,
    this.onSelect,
    this.onDetect,
    this.onClearImage,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<C>(
      init: controller,
      builder: (_) {
        return Scaffold(
          backgroundColor: AppColorConstant.appWhite,
          appBar: AppAppBar(appbarTitle: title),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  padding: const EdgeInsets.all(DimensPadding.paddingNormal),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[messages.length - 1 - index];
                    return ChatMessage<T>(
                      message: message,
                      detectionRenderer: detectionRenderer,
                    );
                  },
                ),
              ),
              InputArea(
                image: image,
                isDetecting: isDetecting,
                selectPrompt: selectPrompt,
                onSelect: onSelect,
                onDetect: onDetect,
                onClearImage: onClearImage,
              ),
            ],
          ),
        );
      },
    );
  }
}
