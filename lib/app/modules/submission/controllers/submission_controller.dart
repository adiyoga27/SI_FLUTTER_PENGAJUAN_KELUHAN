import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:ppju/app/core/app_config.dart';
import 'package:ppju/app/core/utils/fn.dart';
import 'package:ppju/app/model/UserModel.dart';

class SubmissionController extends GetxController {
  RxBool render = false.obs;
  RxBool renderImage = false.obs;
  RxBool renderMaps = false.obs;

  RxBool isSubmit = false.obs;
  final box = GetStorage();
  late UserModel userModel;

  late String markerID = "markerMap";
  final String status = "pending";
  late LatLng latLng = const LatLng(-8.539010, 115.401800);
  LatLng locationMarker = const LatLng(-8.539010, 115.401800);
  CameraPosition cameraPosition =
      const CameraPosition(target: LatLng(-8.539010, 115.401800), zoom: 15.0);
  final ImagePicker imgpicker = ImagePicker();
  List<XFile>? imagefiles;
  final Set<Marker> markers = {};
  late GoogleMapController googleMapController;
  late GoogleMapsPlaces place =
      GoogleMapsPlaces(apiKey: 'AIzaSyC1OvPNohzs2ylS4_G-ZVOcIRv7EovU_xg');
  String googleMapApiKey = "AIzaSyC1OvPNohzs2ylS4_G-ZVOcIRv7EovU_xg";
  Map<String, TextEditingController> forms = {
    'nik': TextEditingController(text: ''),
    'name': TextEditingController(text: ''),
    'phone': TextEditingController(text: ''),
    'complaint_village': TextEditingController(text: ''),
    'title': TextEditingController(text: ''),
    'description': TextEditingController(text: ''),
    'address': TextEditingController(text: '')
  };

  @override
  void onInit() {
    super.onInit();
    userModel = UserModel.fromJson(box.read('user'));
    forms['name']?.text = userModel.name.toString();
    forms['nik']?.text = userModel.nik.toString();

    markers.add(Marker(
      // This marker id can be anything that uniquely identifies each marker.
      markerId: MarkerId(markerID),
      position: latLng,
      infoWindow: const InfoWindow(
        title: "Lokasi Pengaduan",
        //  snippet: '5 Star Rating',
      ),
      icon: BitmapDescriptor.defaultMarker,
    ));
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void onAddMarkerButtonPressed(LatLng latlang) async {
    renderMaps.value = true;
    locationMarker = latlang;
    print(latlang);

    if (markers.isNotEmpty) {
      markers.clear();
    }
    markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(markerID),
        position: latlang,
        infoWindow: const InfoWindow(
          title: "Lokasi Pengaduan",
          //  snippet: '5 Star Rating',
        ),
        icon: BitmapDescriptor.defaultMarker,
        onTap: (() {
          Get.back(result: locationMarker);
        })));
    renderMaps.value = false;
    renderMaps.refresh();
  }

  void setLatLong(LatLng result) {
    latLng = result;
    if (!markers.isEmpty) {
      markers.clear();
    }

    markers.add(Marker(
      // This marker id can be anything that uniquely identifies each marker.
      markerId: MarkerId(markerID),
      position: latLng,
      infoWindow: const InfoWindow(
        title: "Lokasi Pengaduan",
        //  snippet: '5 Star Rating',
      ),
      icon: BitmapDescriptor.defaultMarker,
    ));

    render.value = true;
    render.refresh();
  }

  void openImages() async {
    try {
      var pickedfiles = await imgpicker.pickMultiImage();
      //you can use ImageCourse.camera for Camera capture
      if (pickedfiles != null) {
        imagefiles = pickedfiles;
        renderImage.value = true;
        renderImage.refresh();
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      printError(info: e.toString());
      print("error while picking file.");
    }
  }

  Future sendSubmission() async {
    try {
      isSubmit.value = true;
      if (imagefiles?.length == 0 || imagefiles?.length == null) {
        Fn.toast("Silahkan upload foto terlebih dahulu");
        isSubmit.value = false;
        return;
      }
      var request = http.MultipartRequest(
          'POST', Uri.https(AppConfig.apiBaseUrl, "/api/submission"));
      request.fields.addAll({
        'hp': forms['phone']!.text,
        'complaint_village': forms['complaint_village']!.text,
        'latitude': latLng.latitude.toString(),
        'longitude': latLng.longitude.toString(),
        'title': forms['title']!.text,
        'description': forms['description']!.text
      });
      imagefiles?.forEach((element) async {
        request.files
            .add(await http.MultipartFile.fromPath('images[]', element.path));
      });

      request.headers.addAll(
          {'Accept': 'application/json', 'Authorization': box.read('token')});

      var response = await request.send();

      if (response.statusCode == 201) {
        Fn.toast("Berhasil mengajukan keluahan ");
        clear();
      } else {
        Fn.toast("Gagal mengajukan keluahan ");
      }
    } catch (e, s) {
      printError(info: e.toString());
    }

    isSubmit.value = false;
  }

  void clear() {
    render.value = true;
    forms['phone']?.clear();
    forms['complaint_village']?.clear();
    forms['title']?.clear();
    forms['description']?.clear();
    forms['nik']?.clear();
    forms['name']?.clear();
    forms['address']?.clear();
    imagefiles?.clear();
    render.value = false;
    render.refresh();
  }
}
