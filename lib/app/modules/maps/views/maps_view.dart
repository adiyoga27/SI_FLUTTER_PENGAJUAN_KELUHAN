import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:get/get.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:ppju/app/modules/submission/controllers/submission_controller.dart';
import '../controllers/maps_controller.dart';

final homeScaffoldKey = GlobalKey<ScaffoldState>();

class MapsView extends GetView<MapsController> {
  const MapsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: homeScaffoldKey,
        appBar: AppBar(
          title: const Text("Pilih Lokasi"),
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.search),
                onPressed: () async {
                  Prediction? p = await PlacesAutocomplete.show(
                      context: context,
                      apiKey: controller.kGoogleApiKey,
                      onError: (response) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          elevation: 0,
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.transparent,
                          content: AwesomeSnackbarContent(
                            title: 'Message',
                            message: response.errorMessage!,
                            contentType: ContentType.failure,
                          ),
                        ));
                      },
                      mode: controller.mode,
                      language: 'en',
                      strictbounds: false,
                      types: [""],
                      decoration: InputDecoration(
                          hintText: 'Search',
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.white))),
                      components: [
                        Component(Component.country, "pk"),
                        Component(Component.country, "usa")
                      ]);

                  GoogleMapsPlaces places = GoogleMapsPlaces(
                      apiKey: controller.kGoogleApiKey,
                      apiHeaders: await const GoogleApiHeaders().getHeaders());

                  if (p != null) {
                    // PlacesDetailsResponse detail =
                    //     await places.getDetailsByPlaceId(p?.placeId!);

                    // final lat = detail.result.geometry!.location.lat;
                    // final lng = detail.result.geometry!.location.lng;

                    // controller.markersList.clear();
                    // controller.markersList.add(Marker(
                    //     markerId: const MarkerId("0"),
                    //     position: LatLng(lat, lng),
                    //     infoWindow: InfoWindow(title: detail.result.name)));

                    // controller.googleMapController.animateCamera(
                    //     CameraUpdate.newLatLngZoom(LatLng(lat, lng), 14.0));
                  }
                })
          ],
        ),
        body: Obx(() {
          bool render = controller.render.value;

          return GoogleMap(
            initialCameraPosition:
                CameraPosition(target: controller.locationMarker, zoom: 15.0),
            markers: controller.markers,
            mapType: MapType.normal,
            onMapCreated: (GoogleMapController ctrl) {
              controller.googleMapController = ctrl;
            },
            onLongPress: (latlng) {
              controller.onAddMarkerButtonPressed(latlng);
            },
          );
        }));
  }
}
