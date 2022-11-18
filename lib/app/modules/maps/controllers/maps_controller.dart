import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

class MapsController extends GetxController {
  String kGoogleApiKey = 'AIzaSyC1OvPNohzs2ylS4_G-ZVOcIRv7EovU_xg';
  final Set<Marker> markers = {};
  late LocationPermission permission;
  late GoogleMapsPlaces places =
      GoogleMapsPlaces(apiKey: "AIzaSyC1OvPNohzs2ylS4_G-ZVOcIRv7EovU_xg");
  late String markerID = "markerMap";
  LatLng locationMarker = const LatLng(-8.539010, 115.401800);
  late GoogleMapController googleMapController;
  RxBool render = true.obs;

  final Mode mode = Mode.overlay;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void onAddMarkerButtonPressed(LatLng latlang) async {
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

    render.refresh();
  }
}
