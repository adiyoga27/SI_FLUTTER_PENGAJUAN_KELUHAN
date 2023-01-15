import 'dart:ffi';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocoder2/geocoder2.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:ppju/app/core/values/colors.dart';
import '../controllers/submission_controller.dart';
import 'package:ppju/app/routes/app_pages.dart';

class SubmissionView extends GetView<SubmissionController> {
  const SubmissionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.onInit();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: C.primaryColor,
          title: const Text('Form Pengajuan'),
          centerTitle: true,
          // actions: <Widget>[
          //   IconButton(
          //       icon: const Icon(Icons.search),
          //       onPressed: () async {
          //         Get.toNamed(Routes.MAPS);
          //       })
          // ],
        ),
        body: ListView(
          children: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Obx(() {
                  bool renderMaps = controller.renderMaps.value;
                  return renderMaps
                      ? SizedBox(
                          height: 10.0,
                        )
                      : Stack(
                          children: [
                            Container(
                              height: 300.0,
                              child: GoogleMap(
                                initialCameraPosition:
                                    controller.cameraPosition,
                                markers: controller.markers,
                                mapType: MapType.normal,
                                onMapCreated: (GoogleMapController ctrl) {
                                  controller.googleMapController = ctrl;
                                },
                                onLongPress: (latlng) {
                                  controller.onAddMarkerButtonPressed(latlng);
                                },
                                gestureRecognizers: Set()
                                  ..add(Factory<EagerGestureRecognizer>(
                                      () => EagerGestureRecognizer())),
                              ),
                            ),
                            Positioned(
                                bottom: 1,
                                left: 1,
                                child: ElevatedButton(
                                    child: Text("Pilih Lokasi"),
                                    onPressed: () async {
                                      Prediction? p =
                                          await PlacesAutocomplete.show(
                                              context: context,
                                              apiKey:
                                                  "AIzaSyC1OvPNohzs2ylS4_G-ZVOcIRv7EovU_xg",
                                              mode: Mode
                                                  .overlay, // Mode.fullscreen
                                              language: "id",
                                              types: ["(cities)"],
                                              strictbounds: false,
                                              components: [
                                                new Component(
                                                    Component.country, "id")
                                              ]);
                                      if (p != null) {
                                        PlacesDetailsResponse detail =
                                            await controller.place
                                                .getDetailsByPlaceId(
                                                    p.placeId.toString());

                                        double? lat = detail
                                            .result.geometry?.location.lat;
                                        double? lng = detail
                                            .result.geometry?.location.lng;
                                        LatLng searchLocation =
                                            LatLng(lat!, lng!);
                                        controller.latLng = searchLocation;
                                        controller.locationMarker =
                                            searchLocation;
                                        controller.onAddMarkerButtonPressed(
                                            searchLocation);

                                        controller.googleMapController
                                            .moveCamera(
                                                CameraUpdate.newCameraPosition(
                                                    CameraPosition(
                                                        target: searchLocation,
                                                        zoom: 15.0)));
                                      }
                                    }))
                          ],
                        );
                })),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: controller.forms['nik'],
                decoration: InputDecoration(
                  fillColor: C.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: C.black2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: C.black2),
                  ),
                  labelText: 'NIK *',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: controller.forms['name'],
                decoration: InputDecoration(
                  fillColor: C.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: C.black2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: C.black2),
                  ),
                  labelText: 'Nama *',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: controller.forms['phone'],
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
                  labelText: 'Telp *',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                cursorColor: C.primaryColor,
                controller: controller.forms['complaint_village'],
                decoration: InputDecoration(
                  fillColor: C.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: C.black2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: C.black2),
                  ),
                  labelText: 'Desa Kelurahan *',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: controller.forms['address'],
                decoration: InputDecoration(
                  fillColor: C.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: C.black2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: C.black2),
                  ),
                  labelText: 'Lokasi Gangguan *',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: controller.forms['title'],
                decoration: InputDecoration(
                  fillColor: C.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: C.black2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: C.black2),
                  ),
                  labelText: 'Judul Pengaduan *',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: controller.forms['description'],
                maxLines: 6,
                decoration: InputDecoration(
                  fillColor: C.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: C.black2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: C.black2),
                  ),
                  labelText: 'Detail Pengaduan *',
                ),
              ),
            ),
            Obx(() {
              bool renderImage = controller.renderImage.value;
              return controller.imagefiles != null
                  ? Wrap(
                      children: controller.imagefiles!.map((imageone) {
                        return Container(
                            child: Card(
                          child: Container(
                            height: 100,
                            width: 100,
                            child: Image.file(File(imageone.path)),
                          ),
                        ));
                      }).toList(),
                    )
                  : Container();
            }),
            Padding(
                padding: const EdgeInsets.all(4.0),
                child: ElevatedButton(
                    child: Text("Upload Foto"),
                    onPressed: () async {
                      controller.openImages();
                    })),
          ],
        ),
        floatingActionButton: Obx(() {
          bool isSubmit = controller.isSubmit.value;
          return isSubmit
              ? FloatingActionButton.extended(
                  onPressed: () {
                    // Add your onPressed code here!
                  },
                  label: const Text('Sedang Prosess'),
                  icon: const Icon(Icons.thumb_up),
                  backgroundColor: Colors.grey,
                )
              : FloatingActionButton.extended(
                  onPressed: () {
                    controller.sendSubmission();
                  },
                  label: const Text('Kirim'),
                  icon: const Icon(Icons.send),
                  backgroundColor: Colors.pink,
                );
        }));
  }

  Future<Null> displayPrediction(Prediction p) async {
    if (p != null) {
      // SubmissionController submissionCtrl = Get.put(SubmissionController());
      // PlacesDetailsResponse detail =
      //     await submissionCtrl.place.getDetailsByPlaceId(p.placeId.toString());

      // var placeId = p.placeId;

      // double? lat = detail.result.geometry?.location.lat;
      // double? lng = detail.result.geometry?.location.lng;

      // var address = await Geocoder2.getDataFromCoordinates(
      //     latitude: lat!,
      //     longitude: lng!,
      //     googleMapApiKey: submissionCtrl.googleMapApiKey);
    }
  }
}
