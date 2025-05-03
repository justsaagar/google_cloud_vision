import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:google_cloud_vision/app/helper/extension_helper.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  static final PermissionService instance = PermissionService._internal();

  factory PermissionService() => instance;

  PermissionService._internal();

  Future<bool> requestStorageOrMediaPermission() async {
    if (await isAndroid13orAbove()) {
      return await requestPermission(Permission.photos);
    } else {
      return await requestPermission(Permission.storage);
    }
  }

  Future<bool> isAndroid13orAbove() async {
    if (Platform.isAndroid) {
      final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      if (androidInfo.version.sdkInt >= 33) {
        return true;
      }
    }
    return false;
  }

  Future<bool> requestPermission(Permission permission) async {
    final currentStatus = await permission.status;

    if (currentStatus == PermissionStatus.permanentlyDenied) {
      await openAppSettings();
      return false;
    }

    final status = await permission.request();
    'Permission status --> $status'.infoLogs();

    if (status == PermissionStatus.granted) {
      return true;
    }
    return false;
  }
}
