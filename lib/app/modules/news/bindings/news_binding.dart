import 'package:get/get.dart';
import 'package:ppju/app/modules/notification/controllers/notification_controller.dart';

import '../controllers/news_controller.dart';

class NewsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewsController>(
      () => NewsController(),
    );
    Get.lazyPut<NotificationController>(
      () => NotificationController(),
    );
  }
}
