import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mixins/mixins.dart';
import 'package:ppju/app/core/utils/fn.dart';
import 'package:ppju/app/core/values/colors.dart';
import 'package:ppju/app/model/SubmissionModel.dart';
import 'package:ppju/app/modules/notification/controllers/notification_controller.dart';
import 'package:ppju/app/routes/app_pages.dart';

import '../controllers/news_controller.dart';

class NewsView extends GetView<NewsController> {
  const NewsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final ctrlNotif = Get.put(NotificationController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: C.primaryColor,
        title: const Text('Berita'),
        centerTitle: true,
        actions: <Widget>[
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {
                  Get.toNamed(Routes.NOTIFICATION);
                  // Show notifications
                },
              ),
              ctrlNotif.countNotif.length > 0
                  ? Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          "${ctrlNotif.countNotif.length}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ],
      ),
      body: Obx(() {
        bool isLoadingNews = controller.isLoadingNews.value;
        return RefreshIndicator(
          onRefresh: () => controller.getNews(),
          child: isLoadingNews
              ? Container(
                  child: Padding(
                    padding: EdgeInsets.all(
                      8.0,
                    ),
                    child: ListView.builder(
                        itemCount: 5,
                        itemBuilder: (context, i) {
                          return Card(
                            elevation: 4,
                            child: Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15.0),
                                    child: Skeleton(
                                      size: [Get.width, 200],
                                    ),
                                  ),
                                  Divider(),
                                  Skeleton(
                                    size: [Get.width, 20],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                )
              : controller.listSubmission.length == 0
                  ? Container(
                      child: Center(child: Text("Tidak Ada Berita Saat Ini")),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        itemCount: controller.listSubmission.length,
                        itemBuilder: ((context, index) {
                          SubmissionModel subModel = SubmissionModel.fromJson(
                              controller.listSubmission[index].toJson());

                          return GestureDetector(
                            onTap: () => controller.viewNews(subModel),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              elevation: 3,
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Stack(children: [
                                      subModel.images!.length == 0
                                          ? Container()
                                          : ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: CachedNetworkImage(
                                                width: Get.width,
                                                placeholder: (context, url) =>
                                                    Container(
                                                        child: Center(
                                                            child:
                                                                CircularProgressIndicator())),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                                imageUrl:
                                                    "${subModel.images![0].url}" ??
                                                        '',
                                              ),
                                            ),
                                      Positioned(
                                        bottom: 8,
                                        right: 8,
                                        child: Card(
                                          elevation: 0,
                                          color:
                                              C.primaryColor.withOpacity(0.8),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 8),
                                            child: Text("${subModel.name}",
                                                style:
                                                    TextStyle(color: C.white)),
                                          ),
                                        ),
                                      ),
                                    ]),
                                    Divider(),
                                    const SizedBox(width: 15),
                                    Text(
                                      subModel.title!,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                    const SizedBox(height: 10),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
        );
      }),
    );
  }
}
