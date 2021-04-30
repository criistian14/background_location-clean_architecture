import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (homeCtrl) => Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: ElevatedButton(
                onPressed: homeCtrl.isRunningBackgroundLocation
                    ? homeCtrl.stopLocationService
                    : null,
                child: Text("Dejar de escuchar"),
              ),
            ),
            ElevatedButton(
              onPressed: !homeCtrl.isRunningBackgroundLocation
                  ? homeCtrl.startLocationService
                  : null,
              child: Text("Empezar a escuchar"),
            ),
          ],
        ),
      ),
    );
  }
}
