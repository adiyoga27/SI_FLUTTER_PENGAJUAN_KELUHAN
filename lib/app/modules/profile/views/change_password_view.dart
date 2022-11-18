import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mixins/mixins.dart';
import 'package:ppju/app/core/theme/text_theme.dart';
import 'package:ppju/app/core/utils/fn.dart';
import 'package:ppju/app/core/values/colors.dart';
import 'package:ppju/app/core/values/value.dart';
import 'package:ppju/app/modules/login/controllers/login_controller.dart';
import 'package:ppju/app/modules/profile/views/about_view.dart';
import 'package:ppju/app/widgets/mix_widget.dart';
import '../controllers/profile_controller.dart';

class ChangePasswordView extends GetView<ProfileController> {
  const ChangePasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: C.primaryColor,
        title: const Text('Ganti Password'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    obscureText: true,
                    controller: controller.forms['password'],
                    decoration: InputDecoration(
                      focusColor: C.primaryColor,
                      fillColor: C.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: C.black2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: C.black2),
                      ),
                      labelText: 'New Password',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    obscureText: true,
                    controller: controller.forms['password_confirmation'],
                    decoration: InputDecoration(
                      focusColor: C.primaryColor,
                      fillColor: C.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: C.black2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: C.black2),
                      ),
                      labelText: 'Retry Password',
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Obx(() {
                      bool isSubmit = controller.isSubmit.value;
                      return isSubmit
                          ? ElevatedButton(
                              child: Container(
                                  color: Colors.grey,
                                  height: 40,
                                  width: Get.width,
                                  child: Center(
                                    child: Text(
                                      'Ganti Password',
                                      textAlign: TextAlign.center,
                                    ),
                                  )),
                              onPressed: () async {},
                            )
                          : ElevatedButton(
                              child: Container(
                                  height: 40,
                                  width: Get.width,
                                  child: Center(
                                    child: Text(
                                      'Ganti Password',
                                      textAlign: TextAlign.center,
                                    ),
                                  )),
                              onPressed: () async {
                                controller.changePassword();
                              },
                            );
                    }))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
