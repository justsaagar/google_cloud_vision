import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_cloud_vision/app/constant/color_constant.dart';
import 'package:logger/logger.dart';

extension SnackBar on String {
  showInfo() {
    kDebugMode
        ? Get.snackbar(
            'Info!!',
            this,
            backgroundColor: AppColorConstant.appGrey,
            colorText: AppColorConstant.appWhite,
          )
        : null;
  }

  showError() {
    Get.snackbar(
      'Error!!',
      this,
      backgroundColor: AppColorConstant.appErrorColor,
      colorText: AppColorConstant.appWhite,
    );
  }

  showRequire() {
    Get.snackbar(
      'Requirement!!',
      this,
      backgroundColor: AppColorConstant.appYellow,
      colorText: AppColorConstant.appWhite,
    );
  }

  showSuccess() {
    Get.snackbar(
      'Success!!',
      this,
      backgroundColor: AppColorConstant.appSuccessColor,
      colorText: AppColorConstant.appWhite,
    );
  }

  void logs() {
    if (kDebugMode) Logger(printer: PrettyPrinter(methodCount: 0)).d(this);
  }

  void infoLogs() {
    if (kDebugMode) Logger(printer: PrettyPrinter(methodCount: 0)).i(this);
  }

  void warningLogs() {
    if (kDebugMode) Logger(printer: PrettyPrinter(methodCount: 0)).w(this);
  }

  void errorLogs() {
    if (kDebugMode) Logger(printer: PrettyPrinter(methodCount: 0)).e(this);
  }
}
