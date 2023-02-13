import 'dart:convert';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ppju/app/core/app_config.dart';
import 'package:ppju/app/model/SubmissionModel.dart';
import 'package:http/http.dart' as http;
import 'package:ppju/app/routes/app_pages.dart';

class NewsController extends GetxController {
  //TODO: Implement NewsController
  final box = GetStorage();
  late SubmissionModel selectedSubmission;
  final CarouselController carouselCtrl = CarouselController();
  late List<SubmissionModel> listSubmission = [];
  RxInt indicator = 1.obs;
  RxBool isLoadingNews = false.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
    await getNews();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future getNews() async {
    print('Get News');
    isLoadingNews.value = true;

    var response = await http.get(
      Uri.http(AppConfig.apiBaseUrl, "/api/submission/news"),
      headers: {
        'Accept': "application/json",
        'Authorization': box.read('token')
      },
    );

    var body = json.decode(response.body);
    listSubmission =
        (body['data'] as List).map((i) => SubmissionModel.fromJson(i)).toList();
    isLoadingNews.value = false;
    print(listSubmission.length);
    isLoadingNews.refresh();
  }

  void viewNews(SubmissionModel submissionModel) {
    selectedSubmission = submissionModel;
    Get.toNamed(Routes.DETAILNEWS);
  }

  void slide(int index) {
    indicator.value = index;
    indicator.refresh();
  }
}
