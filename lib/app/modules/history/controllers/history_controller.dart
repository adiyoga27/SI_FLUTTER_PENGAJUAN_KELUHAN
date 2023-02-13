import 'dart:convert';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ppju/app/core/app_config.dart';
import 'package:ppju/app/model/SubmissionModel.dart';
import 'package:http/http.dart' as http;
import 'package:ppju/app/model/UserModel.dart';
import 'package:ppju/app/routes/app_pages.dart';

class HistoryController extends GetxController {
  //TODO: Implement NewsController
  final box = GetStorage();
  late SubmissionModel selectedSubmission;
  final CarouselController carouselCtrl = CarouselController();
  late List<SubmissionModel> listSubmission = [];
  RxInt indicator = 1.obs;
  RxBool isLoadingHistory = false.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
    await getHistory();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future getHistory() async {
    print('Get News');

    isLoadingHistory.value = true;

    var response = await http.get(
      Uri.http(AppConfig.apiBaseUrl, "/api/submission"),
      headers: {
        'Accept': "application/json",
        'Authorization': box.read('token') ?? ""
      },
    );

    var body = json.decode(response.body);
    if (body['data'] != null) {
      listSubmission = (body['data'] as List)
          .map((i) => SubmissionModel.fromJson(i))
          .toList();
      isLoadingHistory.value = false;
      print(listSubmission.length);
      isLoadingHistory.refresh();
    }
  }

  void viewHistory(SubmissionModel submissionModel) {
    selectedSubmission = submissionModel;
    Get.toNamed(Routes.DETAILHISTORY);
  }

  void slide(int index) {
    indicator.value = index;
    indicator.refresh();
  }
}
