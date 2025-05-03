import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_cloud_vision/app/constant/string_constant.dart';
import 'package:google_cloud_vision/app/utills/dimension.dart';
import 'package:google_cloud_vision/app/widgets/app_button.dart';
import 'package:google_cloud_vision/app/widgets/app_text.dart';
import 'package:google_cloud_vision/services/permission_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class AppFunction {
  static Future<File?> selectImageFromGallery() async {
    final permissionGranted = await PermissionService.instance.requestStorageOrMediaPermission();
    if (!permissionGranted) return null;

    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  /// Shows a dialog to select an image from either camera or gallery.
  static Future<File?> selectImageFromCameraOrGallery() async {
    final source = await Get.dialog<ImageSource>(
      AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const AppText(StringConstant.selectImageOption),
            const SizedBox(height: Dimens.heightMedium),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: AppButton(
                    title: StringConstant.camera,
                    onPressed: () => Get.back(result: ImageSource.camera),
                    margin: EdgeInsets.zero,
                  ),
                ),
                SizedBox(width: Dimens.widthNormal),
                Expanded(
                  child: AppButton(
                    title: StringConstant.gallery,
                    onPressed: () => Get.back(result: ImageSource.gallery),
                    margin: EdgeInsets.zero,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    if (source != null) {
      if (source == ImageSource.gallery) {
        return await selectImageFromGallery();
      }
      if (source == ImageSource.camera) {
        final permissionGranted = await PermissionService.instance.requestPermission(Permission.camera);
        if (!permissionGranted) return null;

        final pickedFile = await ImagePicker().pickImage(source: source);
        if (pickedFile != null) {
          return File(pickedFile.path);
        }
      }
    }
    return null;
  }
}
