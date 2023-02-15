import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ppju/app/core/app_config.dart';
import 'package:ppju/app/model/SubmissionModel.dart';
import 'package:ppju/app/modules/history/controllers/history_controller.dart';
import 'package:http/http.dart' as http;
import 'package:ppju/app/modules/news/controllers/news_controller.dart';

class NotificationController extends GetxController {
  //TODO: Implement NotificationController
  List<String> _items = [];
  final box = GetStorage();
  final ctrlHistory = Get.put(HistoryController());
  final count = 0.obs;
  final collection = FirebaseFirestore.instance.collection("notifications");
  RxList countNotif = [].obs;

  var token = "";
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

  void increment() => count.value++;

  void redirectToDetail(String id) async {
    var response = await http.get(
      Uri.http(AppConfig.apiBaseUrl, "/api/submission/$id"),
      headers: {
        'Accept': "application/json",
        'Authorization': box.read('token') ?? ""
      },
    );

    var body = json.decode(response.body);
    if (body['data'] != null) {
      final ctrlNews = Get.put(NewsController());
      ctrlNews.getNotif();
      SubmissionModel submissionModel = SubmissionModel.fromJson(body['data']);
      return ctrlHistory.viewHistory(submissionModel);
    }
  }

  String getNik() {
    return box.read('user')['nik'];
  }
}
