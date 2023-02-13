import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ppju/app/core/app_config.dart';
import 'package:ppju/app/core/utils/fn.dart';
import 'package:ppju/app/routes/app_pages.dart';

class RegistrationController extends GetxController {
  //TODO: Implement RegistrationController
  Map<String, TextEditingController> forms = {
    'nik': TextEditingController(text: ''),
    'name': TextEditingController(text: ''),
    'email': TextEditingController(text: ''),
    'username': TextEditingController(text: ''),
    'password': TextEditingController(text: ''),
  };
  RxBool isSubmit = false.obs;
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

  Future registration() async {
    try {
      Map<String, dynamic> map = forms;

      isSubmit.value = true;
      print(isSubmit);
      var response = await http.post(
          Uri.http(AppConfig.apiBaseUrl, "/api/auth/registration"),
          headers: {
            'Accept': "application/json"
          },
          body: {
            'nik': forms['nik']?.text,
            'name': forms['name']?.text,
            'email': forms['email']?.text,
            'username': forms['username']?.text,
            'password': forms['password']?.text
          });

      var body = json.decode(response.body);
      if (response.statusCode == 200) {
        if (body['status']) {
          Fn.toast(body['message']);
          Get.offAllNamed(Routes.LOGIN);
        }
      } else {
        Fn.toast(body['message'], time: 4);
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e, s) {
      Fn.toast("Gagal Registrasi");
    }
    isSubmit.value = false;
  }
}
