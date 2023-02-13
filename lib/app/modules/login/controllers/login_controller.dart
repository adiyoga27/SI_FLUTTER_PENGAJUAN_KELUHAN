import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:ppju/app/core/app_config.dart';
import 'package:ppju/app/model/UserModel.dart';
import 'package:ppju/app/routes/app_pages.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController
  late UserModel userModel;
  final box = GetStorage();
  Map<String, TextEditingController> forms = {
    'username': TextEditingController(text: ''),
    'password': TextEditingController(text: '')
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

  Future login() async {
    try {
      Map<String, dynamic> map = forms;

      isSubmit.value = true;
      print(isSubmit);
      var response = await http
          .post(Uri.http(AppConfig.apiBaseUrl, "/api/auth/login"), body: {
        'username': forms['username']?.text,
        'password': forms['password']?.text
      });
      print(response.statusCode);

      if (response.statusCode == 200) {
        // if (res.status) {
        //   // save token data to secure storage
        //   String token = 'Bearer ${res.body['token']}';
        //   await SecureStorage.write('token', token);

        //   String scope = res.body['scope'];

        //   // save user data to local storage
        //   storage.write('user', res.body['user']);
        //   storage.write('user_scope', scope);

        //   // set token in Dio
        //   FetchConfig.setToken('Bearer $token');

        //   // set delay about 150 ms, then redirect to home page
        //   Mixins.timer(() => Get.offAndToNamed(Routes.home), 150);
        // } else {
        //   toast.error(res.message);
        // }
        var body = json.decode(response.body);
        if (body['status']) {
          userModel = UserModel.fromJson(body['data']);
          String token = 'Bearer ${body['data']['token']}';
          box.write('token', token);
          box.write('user', body['data']);
          Get.offAllNamed(Routes.HOME);
          print(token);
        }
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
      // if (res.status) {
      //   // save token data to secure storage
      //   String token = 'Bearer ${res.body['token']}';
      //   await SecureStorage.write('token', token);

      //   String scope = res.body['scope'];

      //   // save user data to local storage
      //   storage.write('user', res.body['user']);
      //   storage.write('user_scope', scope);

      //   // set token in Dio
      //   FetchConfig.setToken('Bearer $token');

      //   // set delay about 150 ms, then redirect to home page
      //   Mixins.timer(() => Get.offAndToNamed(Routes.home), 150);
      // } else {
      //   toast.error(res.message);
      // }
    } catch (e, s) {
      printError(info: e.toString());
    }

    isSubmit.value = false;
  }

  void logout() {
    box.remove('token');
    box.remove('user');

    Get.offAndToNamed(Routes.INITIAL);
  }
}
