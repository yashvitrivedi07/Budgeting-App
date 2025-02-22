import 'package:budget_tracker_app/screens/detail_screen.dart';
import 'package:budget_tracker_app/screens/home/views/home_page.dart';
import 'package:budget_tracker_app/screens/splash_screen.dart';
import 'package:get/get.dart';

class GetPages {
  static String splash = '/';
  static String home = '/home';
  static String detail = '/detail';

  static List<GetPage<dynamic>> pages = [
    GetPage(
      name: splash,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: home,
      page: () => HomePage(),
    ),
    GetPage(
      name: detail,
      page: () => DetailScreen(),
    )
  ];
}
