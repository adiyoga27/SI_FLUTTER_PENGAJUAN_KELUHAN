import 'package:get/get.dart';
import 'package:ppju/app/modules/history/controllers/history_controller.dart';
import 'package:ppju/app/modules/news/controllers/news_controller.dart';
import 'package:ppju/app/modules/notification/controllers/notification_controller.dart';

import '../controllers/initial_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InitialController>(
      () => InitialController(),
    );
    Get.lazyPut<NewsController>(
      () => NewsController(),
    );
    Get.lazyPut<HistoryController>(
      () => HistoryController(),
    );
    Get.lazyPut<NotificationController>(
      () => NotificationController(),
    );
  }
}
