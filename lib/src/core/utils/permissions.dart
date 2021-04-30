import 'package:permission_handler/permission_handler.dart';

class PermissionsApp {
  static Future<bool> checkLocationPermission() async {
    PermissionStatus status = await Permission.locationAlways.status;

    switch (status) {
      case PermissionStatus.limited:
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
        return await Permission.locationAlways.request().isGranted;
        break;
      case PermissionStatus.permanentlyDenied:
        openAppSettings();

        return checkLocationPermission();
        break;
      case PermissionStatus.granted:
        return true;
        break;
      default:
        return false;
        break;
    }
  }
}
