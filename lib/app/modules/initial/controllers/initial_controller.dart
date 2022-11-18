import 'dart:async';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ppju/app/routes/app_pages.dart';

class InitialController extends GetxController {
  //TODO: Implement InitialController
  final box = GetStorage();
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
    Timer(Duration(seconds: 5), () {
      print(box.read('token'));

      if (box.read('token') == null || box.read('token') == "") {
        Get.offAllNamed(Routes.LOGIN);
      } else {
        Get.offAllNamed(Routes.HOME);
      }
    });

    if (await Permission.location.isPermanentlyDenied) {
      openAppSettings();
    }
    var status = await Permission.location.status;
    if (status.isDenied) {
      await Permission.location.request();
      // We didn't ask for permission yet or the permission has been denied before but not permanently.
    }

    // You can can also directly ask the permission about its status.
    if (await Permission.location.isRestricted) {
      openAppSettings();

      // The OS restricts access, for example because of parental controls.
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  void redirectRoute() {
    print("playyy");
    print(box.read('token'));
    super.onInit();
    if (box.read('token') == null || box.read('token') == "") {
      Get.toNamed(Routes.LOGIN);
    } else {
      Get.toNamed(Routes.HOME);
    }
  }

  void increment() => count.value++;
}
