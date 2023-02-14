import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
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
  final collection = FirebaseFirestore.instance.collection("notifications");
  final List countNotif = [];

  var token = "";
  @override
  void onInit() {
    super.onInit();
    getCount();
  }

  @override
  void onReady() {
    super.onReady();
    getCount();
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

  String getNik() {
    return box.read('user')['nik'];
  }

  getCount() {
    final notif = collection
        .where('to', isEqualTo: box.read('user')['nik'].toString())
        .snapshots();
    notif.listen((event) {
      event.docs.forEach((element) {
        print(element.toString());
        countNotif.add(element.data());
      });
    });
    update();
  }
}
