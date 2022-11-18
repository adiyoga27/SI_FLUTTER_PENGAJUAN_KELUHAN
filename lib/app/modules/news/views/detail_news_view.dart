import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ppju/app/core/theme/text_theme.dart';
import 'package:ppju/app/core/utils/fn.dart';
import 'package:ppju/app/core/values/colors.dart';
import 'package:ppju/app/model/SubmissionModel.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../controllers/news_controller.dart';

class DetailNewsView extends GetView<NewsController> {
  const DetailNewsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSliders = controller.selectedSubmission.images!
        .map((item) => Container(
              child: Container(
                width: Get.width,
                margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: CachedNetworkImage(
                      width: Get.width,
                      placeholder: (context, url) =>
                          Container(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      imageUrl: "${item.url}" ?? '',
                    )),
              ),
            ))
        .toList();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: C.primaryColor,
          title: const Text('Berita'),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${controller.selectedSubmission.title}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
            CarouselSlider(
              items: imageSliders,
              carouselController: controller.carouselCtrl,
              options: CarouselOptions(
                  autoPlay: false,
                  enlargeCenterPage: true,
                  aspectRatio: 4.0 / 3.0,
                  onPageChanged: (index, reason) {
                    controller.slide(index);
                  }),
            ),
            Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: controller.selectedSubmission.images!
                    .asMap()
                    .entries
                    .map((entry) {
                  return GestureDetector(
                    child: Container(
                      width: 12.0,
                      height: 12.0,
                      margin:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              (Theme.of(context).brightness == Brightness.dark
                                      ? Colors.white
                                      : Colors.black)
                                  .withOpacity(controller.indicator == entry.key
                                      ? 0.9
                                      : 0.4)),
                    ),
                  );
                }).toList(),
              );
            }),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('${controller.selectedSubmission.description}'),
            ),
          ],
        ));
  }
}
