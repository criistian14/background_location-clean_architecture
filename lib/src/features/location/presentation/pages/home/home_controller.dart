import 'dart:async';
import 'dart:isolate';
import 'dart:ui';

import 'package:background_locator/background_locator.dart';
import 'package:background_locator/settings/android_settings.dart';
import 'package:background_locator/settings/ios_settings.dart';
import 'package:background_locator/settings/locator_settings.dart';
import 'package:get/get.dart';
import 'package:location_clean_architecture/src/core/utils/background_location/location_callback_handler.dart';
import 'package:location_clean_architecture/src/core/utils/background_location/location_service_repository.dart';
import 'package:location_clean_architecture/src/core/utils/permissions.dart';

class HomeController extends GetxController {
  ReceivePort _port = ReceivePort();
  bool isRunningBackgroundLocation = false;
  Stream _backgroundLocationStream;
  StreamSubscription _backgroundLocationStreamSubs;

  @override
  void onInit() async {
    super.onInit();

    await initBackgroundLocation();

    if (!isRunningBackgroundLocation) {
      startLocationService();
    }
  }

  Future<void> initBackgroundLocation() async {
    // Check if the port is already used
    if (IsolateNameServer.lookupPortByName(
            LocationServiceRepository.isolateName) !=
        null) {
      IsolateNameServer.removePortNameMapping(
          LocationServiceRepository.isolateName);
    }

    // Register the service to the port name
    IsolateNameServer.registerPortWithName(
      _port.sendPort,
      LocationServiceRepository.isolateName,
    );

    _backgroundLocationStream = _port.asBroadcastStream();
    _backgroundLocationStreamSubs = _backgroundLocationStream.listen((event) {
      print("------------- Location by port -------------");
    });

    isRunningBackgroundLocation = await BackgroundLocator.isServiceRunning();
    update();
  }

  void startLocationService() async {
    await BackgroundLocator.initialize();

    if (!await PermissionsApp.checkLocationPermission()) return;

    _startLocator();

    if (_backgroundLocationStreamSubs != null) {
      await _backgroundLocationStreamSubs.cancel();
    }
    _backgroundLocationStreamSubs = _backgroundLocationStream.listen((event) {
      print("------------- Location by port -------------");
    });

    isRunningBackgroundLocation = await BackgroundLocator.isServiceRunning();
    update();
  }

  void _startLocator() {
    BackgroundLocator.registerLocationUpdate(
      LocationCallbackHandler.callback,
      autoStop: false,
      androidSettings: AndroidSettings(
        accuracy: LocationAccuracy.NAVIGATION,
        interval: 5,
        distanceFilter: 0,
        androidNotificationSettings: AndroidNotificationSettings(
          notificationChannelName: "Obteniendo Localizacion",
          notificationTitle: "Obteniendo Localizacion",
          notificationMsg: "Obteniendo Localizacion en segundo plano",
        ),
      ),
      iosSettings: IOSSettings(
        accuracy: LocationAccuracy.NAVIGATION,
        distanceFilter: 0,
      ),
    );
  }

  void stopLocationService() async {
    await _backgroundLocationStreamSubs.cancel();
    await BackgroundLocator.unRegisterLocationUpdate();
    isRunningBackgroundLocation = await BackgroundLocator.isServiceRunning();
    update();
  }
}
