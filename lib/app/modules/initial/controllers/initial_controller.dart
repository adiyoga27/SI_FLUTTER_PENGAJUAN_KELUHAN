import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ppju/app/core/app_config.dart';
import 'package:ppju/app/model/SubmissionModel.dart';
import 'package:ppju/app/modules/history/controllers/history_controller.dart';
import 'package:ppju/app/routes/app_pages.dart';
import 'package:http/http.dart' as http;

class InitialController extends GetxController {
  //TODO: Implement InitialController
  final box = GetStorage();
  final count = 0.obs;

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final _historyController = Get.put(HistoryController());
  @override
  void onInit() {
    super.onInit();
    _firebaseMessaging.requestPermission();
    _firebaseMessaging.getInitialMessage().then((RemoteMessage? message) {
      print('getInitialMessage data: ${message?.data}');
      if (message != null) {
        redirectMessage(message!.data['data']);
      }
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("onMessage data: ${message.data}");
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('onMessageOpenedApp data: ${message.data}');
    });
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

  redirectMessage(int id) async {
    final HistoryController _historyController = HistoryController();
    var response = await http.get(
      Uri.http(AppConfig.apiBaseUrl, "/api/submission/$id"),
      headers: {
        'Accept': "application/json",
        'Authorization': box.read('token')
      },
    );
    var body = json.decode(response.body);
    SubmissionModel submissionModel = SubmissionModel.fromJson(body['data']);
    _historyController.viewHistory(submissionModel);
  }

  void increment() => count.value++;
}
