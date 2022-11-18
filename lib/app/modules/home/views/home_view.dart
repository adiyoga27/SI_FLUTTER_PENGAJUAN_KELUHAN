import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ppju/app/core/values/colors.dart';
import 'package:ppju/app/modules/history/views/history_view.dart';
import 'package:ppju/app/modules/news/controllers/news_controller.dart';
import 'package:ppju/app/modules/news/views/news_view.dart';
import 'package:ppju/app/modules/profile/views/profile_view.dart';
import 'package:ppju/app/modules/submission/controllers/submission_controller.dart';
import 'package:ppju/app/modules/submission/views/submission_view.dart';
import 'package:toast/toast.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final submissionController = Get.put(SubmissionController());
    return Obx(() {
      submissionController.onInit();
      int pageActive = controller.tabIndex.value;

      return Scaffold(
        body: SafeArea(
          child: IndexedStack(
            index: controller.tabIndex.value,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const NewsView(),
              const SubmissionView(),
              const HistoryView(),
              const ProfileView(),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: controller.tabIndex.value,
          onItemSelected: controller.changeTabIndex,
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
                title: Text('Berita'),
                icon: Icon(Icons.home),
                inactiveColor: Colors.grey,
                activeColor: C.primaryColor),
            BottomNavyBarItem(
                title: Text('Pengajuan'),
                icon: Icon(Icons.apps),
                inactiveColor: Colors.grey,
                activeColor: C.primaryColor),
            BottomNavyBarItem(
                title: Text('Diterima'),
                icon: Icon(Icons.chat_bubble),
                inactiveColor: Colors.grey,
                activeColor: C.primaryColor),
            BottomNavyBarItem(
                title: Text('Profile'),
                icon: Icon(Icons.settings),
                inactiveColor: Colors.grey,
                activeColor: C.primaryColor),
          ],
        ),
      );
    });
  }
}
