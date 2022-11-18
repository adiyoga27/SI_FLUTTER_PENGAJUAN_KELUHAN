import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:ppju/app/core/app_config.dart';
import 'package:ppju/app/core/utils/fn.dart';
import 'package:ppju/app/routes/app_pages.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController
  final box = GetStorage();
  RxBool isSubmit = false.obs;
  Map<String, TextEditingController> forms = {
    'password': TextEditingController(text: ''),
    'password_confirmation': TextEditingController(text: ''),
  };
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

  Future changePassword() async {
    try {
      if (forms['password']!.text.isEmpty) {
        Fn.toast('Silakan Masukkan Password baru.');
        return;
      }
      if (forms['password_confirmation']!.text.isEmpty) {
        Fn.toast('Silakan Masukkan Ulang Password Baru Anda.');
        return;
      }
      if (forms['password']!.text != forms['password_confirmation']!.text) {
        Fn.toast('Password tidak sama silahkan ulangi  kembali');
        return;
      }
      isSubmit.value = true;

      var response = await http.post(
          Uri.https(AppConfig.apiBaseUrl, "/api/auth/change-password"),
          headers: {
            'Accept': "application/json",
            'Authorization': box.read('token')
          },
          body: {
            'password': forms['password']?.text,
            'password_confirmation': forms['password_confirmation']?.text
          });

      var body = json.decode(response.body);
      printError(info: body.toString());
      if (response.statusCode == 200) {
        if (body['status']) {
          Fn.toast(body['message']);
          isSubmit.value = false;
          isSubmit.refresh();
          box.remove('token');
          box.remove('user');
          Fn.toast(body['message'], time: 4);
          Get.offAllNamed(Routes.INITIAL);
        }
      } else {
        isSubmit.value = false;
        isSubmit.refresh();
        Fn.toast(body['message'], time: 4);
      }
    } catch (e, s) {
      printError(info: e.toString());
      isSubmit.value = false;
      isSubmit.refresh();
      Fn.toast("Gagal Reset Password", time: 4);
    }
  }
}
