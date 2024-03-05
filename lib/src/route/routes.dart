
import 'package:gemini/src/constant/page.dart';
import 'package:get/get.dart';

class Routes {
  static final route = [
    GetPage(
        name: RouteConstant.HOME,
        page: () => const HomeView(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 200)
    ),
  ];
}