import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ppju/app/core/values/colors.dart';
import 'package:ppju/app/model/SubmissionModel.dart';
import 'package:ppju/app/widgets/mix_widget.dart';

import '../controllers/history_controller.dart';

class HistoryView extends GetView<HistoryController> {
  const HistoryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: C.primaryColor,
        title: const Text('History'),
        centerTitle: true,
      ),
      body: Obx(() {
        bool isLoadingNews = controller.isLoadingHistory.value;
        return RefreshIndicator(
          onRefresh: () => controller.getHistory(),
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
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15.0),
                                    child: Skeleton(
                                      size: [150, 150],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Column(
                                    children: [
                                      Skeleton(
                                        size: [Get.width / 2, 20],
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Skeleton(
                                        size: [Get.width / 2, 20],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: controller.listSubmission.length,
                    itemBuilder: ((context, index) {
                      SubmissionModel subModel = SubmissionModel.fromJson(
                          controller.listSubmission[index].toJson());

                      return GestureDetector(
                        onTap: () => controller.viewHistory(subModel),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          elevation: 3,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              subModel.images!.length == 0
                                  ? Container()
                                  : Stack(
                                      children: [
                                        ClipRRect(
                                          child: Container(
                                            child: CachedNetworkImage(
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      Container(
                                                width: 150.0,
                                                height: 150.0,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.rectangle,
                                                  image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.cover),
                                                ),
                                              ),
                                              placeholder: (context, url) =>
                                                  Container(
                                                      child:
                                                          CircularProgressIndicator()),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                              imageUrl:
                                                  "${subModel.images![0].url}" ??
                                                      '',
                                            ),
                                          ),
                                        ),
                                        subModel.status != null
                                            ? Positioned(
                                                bottom: 8,
                                                left: 8,
                                                child: Card(
                                                  elevation: 0,
                                                  color: subModel.status ==
                                                          'pending'
                                                      ? C.black5
                                                          .withOpacity(0.8)
                                                      : subModel.status ==
                                                              'success'
                                                          ? C.green
                                                              .withOpacity(0.8)
                                                          : subModel.status ==
                                                                  'progress'
                                                              ? C.yellow
                                                                  .withOpacity(
                                                                      0.8)
                                                              : C.primaryColor
                                                                  .withOpacity(
                                                                      0.8),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10,
                                                        vertical: 8),
                                                    child: Text(
                                                        "${subModel.status}",
                                                        style: TextStyle(
                                                            color: C.white)),
                                                  ),
                                                ),
                                              )
                                            : SizedBox(
                                                height: 1.0,
                                              ),
                                      ],
                                    ),
                              Divider(),
                              const SizedBox(width: 15),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, bottom: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 50,
                                          child: const Text(
                                            "Judul",
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        const Text(":",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15)),
                                        const SizedBox(width: 10),
                                        Container(
                                          width: Get.width / 2.5,
                                          child: Text(
                                            "${subModel.title}",
                                            maxLines: 20,
                                            overflow: TextOverflow.ellipsis,
                                            style:
                                                const TextStyle(fontSize: 12),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Container(
                                          width: 50,
                                          child: const Text(
                                            "Desa",
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        const Text(":",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15)),
                                        const SizedBox(width: 10),
                                        Text(
                                          subModel.complaintVillage!,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
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
