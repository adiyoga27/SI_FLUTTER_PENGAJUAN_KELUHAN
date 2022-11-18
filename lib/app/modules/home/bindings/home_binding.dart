import 'package:get/get.dart';
import 'package:ppju/app/modules/news/controllers/news_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<NewsController>(
      () => NewsController(),
    );
  }
}
