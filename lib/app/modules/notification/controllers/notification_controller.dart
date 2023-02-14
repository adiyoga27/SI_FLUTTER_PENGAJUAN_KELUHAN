import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ppju/app/core/app_config.dart';
import 'package:ppju/app/model/SubmissionModel.dart';
import 'package:ppju/app/modules/history/controllers/history_controller.dart';
import 'package:http/http.dart' as http;

class NotificationController extends GetxController {
  //TODO: Implement NotificationController
  List<String> _items = [];
  final box = GetStorage();

  final ctrlHistory = Get.put(HistoryController());
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
      SubmissionModel submissionModel = SubmissionModel.fromJson(body['data']);
      return ctrlHistory.viewHistory(submissionModel);
    }
  }
}
