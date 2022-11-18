import 'package:get/get.dart';
import 'package:ppju/app/modules/news/controllers/news_controller.dart';
import 'package:ppju/app/modules/submission/controllers/submission_controller.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  final tabIndex = 0.obs;
  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void changeTabIndex(int index) {
    tabIndex.value = index;
    update();
  }

  void increment() => count.value++;
}
