import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ppju/app/core/theme/text_theme.dart';
import 'package:ppju/app/core/utils/fn.dart';
import 'package:ppju/app/core/values/colors.dart';
import 'package:ppju/app/model/SubmissionModel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ppju/app/modules/history/controllers/history_controller.dart';

class DetailHistoryView extends GetView<HistoryController> {
  const DetailHistoryView({Key? key}) : super(key: key);
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
          title: const Text('Detail Pengajuan'),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${controller.selectedSubmission.title}',
                textAlign: TextAlign.center,
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
              child: Text(
                "Deskripsi",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('${controller.selectedSubmission.description}'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Lokasi",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('${controller.selectedSubmission.complaintVillage}'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Posisi",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 300.0,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                      target: LatLng(
                          double.parse(controller.selectedSubmission.latitude
                              .toString()),
                          double.parse(controller.selectedSubmission.longtitude
                              .toString())),
                      zoom: 15.0),
                  markers: <Marker>{
                    Marker(
                      // This marker id can be anything that uniquely identifies each marker.
                      markerId: MarkerId("test"),
                      position: LatLng(
                          double.parse(controller.selectedSubmission.latitude
                              .toString()),
                          double.parse(controller.selectedSubmission.longtitude
                              .toString())),
                      infoWindow: const InfoWindow(
                        title: "Lokasi Pengaduan",
                        //  snippet: '5 Star Rating',
                      ),
                      icon: BitmapDescriptor.defaultMarker,
                    )
                  },
                  mapType: MapType.normal,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Status Pengajuan",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 0,
                color: controller.selectedSubmission.status == 'pending'
                    ? C.black5.withOpacity(0.8)
                    : controller.selectedSubmission.status == 'success'
                        ? C.green.withOpacity(0.8)
                        : controller.selectedSubmission.status == 'progress'
                            ? C.yellow.withOpacity(0.8)
                            : C.primaryColor.withOpacity(0.8),
                child: Container(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    child: Text("${controller.selectedSubmission.status}",
                        style: TextStyle(color: C.white)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Note Petugas",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('-'),
            ),
            SizedBox(
              height: 100.0,
            )
          ],
        ));
  }
}
