import 'package:get/get.dart';
import 'package:location_clean_architecture/src/features/location/presentation/pages/home/home_binding.dart';
import 'package:location_clean_architecture/src/features/location/presentation/pages/home/home_page.dart';

import 'app_routes.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.HOME,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
  ];
}
