import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/initial_controller.dart';

class InitialView extends GetView<InitialController> {
  const InitialView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.onInit();
    return Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                height: 300,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/images/ppju.png'),
                ))),
            const SizedBox(
              height: 25,
            ),
            const Text(
              "IMPLEMENTASI SISTEM INFORMASI PENGADUAN PENERANGAN JALAN UMUM BERBASIS MOBILE PADA DINAS PERHUBUNGAN KABUPATEN KLUNGKUNG",
              style: TextStyle(
                  decorationColor: Colors.white,
                  backgroundColor: Colors.white,
                  color: Colors.black,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 25,
            ),
            const SizedBox(
                height: 15, width: 15, child: CircularProgressIndicator())
          ],
        ));
  }
}
