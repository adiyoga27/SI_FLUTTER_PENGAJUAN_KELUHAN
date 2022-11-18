import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocoder2/geocoder2.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import '../controllers/maps_controller.dart';
class MapsViewOld extends GetView<MapsController> {
  const MapsViewOld({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_new
    return new Scaffold(
      appBar: AppBar(
        title: const Text('HistoryView'),
        centerTitle: true,
         actions: <Widget>[
          IconButton(icon: Icon(Icons.search),
              onPressed: () async {
                   Prediction? p = await PlacesAutocomplete.show(
                    context: context,
                    apiKey: "AIzaSyBE8zlA-JAfxHu_siE052F3-A7W83jVCBM",
                    // onError: (){ return print('errorrrsss');},
                    // mode: Mode.overlay,
                    language: 'en',
                    strictbounds: false,
                    types: [""],
                    decoration: InputDecoration(
                        hintText: 'Search',
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: Colors.white))),
                    components: [Component(Component.country,"pk"),Component(Component.country,"usa")]);


              })
        ],
      ),
        body: 
        GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: const CameraPosition(
            target: LatLng(-8.539010, 115.401800),
            zoom: 15,
          ),
          onMapCreated: (GoogleMapController ctr) {
            // controller.setMaps(ctr);
          },
          onLongPress: ((latlng) {
            print(latlng);
            controller.onAddMarkerButtonPressed(latlng);
          }),
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          markers: controller.markers,
    ));
  }
}

 