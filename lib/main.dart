import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'src/core/routes/app_pages.dart';
import 'src/features/location/presentation/pages/home/home_binding.dart';
import 'src/features/location/presentation/pages/home/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: () => GetMaterialApp(
        title: 'Background Location',
        debugShowCheckedModeBanner: false,
        home: HomePage(),
        initialBinding: HomeBinding(),
        getPages: AppPages.pages,
        defaultTransition: Transition.cupertino,
        popGesture: true,
      ),
    );
  }
}
