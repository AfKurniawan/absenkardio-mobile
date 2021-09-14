import 'dart:async';

import 'package:absensi_prodi/src/styles/light_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsWidget extends StatefulWidget {
  @override
  _MapsWidgetState createState() => _MapsWidgetState();
}

class _MapsWidgetState extends State<MapsWidget> {
  Future<Position> _future;
  Set<Marker> _markers = {};
  final Geolocator geolocator = Geolocator();
  List<Placemark> placemarks;

  LatLng _userLocation;

  Position position;
  String _currentAddress;
  GoogleMapController _mapController;
  Widget _child;
  Placemark place ;

  @override
  void initState() {
    super.initState();
    _child = SpinKitDoubleBounce(color: LightColor.unsBlue);
    getCurrentLocation();


  }

  void getCurrentLocation() async {
    Position res = await Geolocator.getCurrentPosition();
    setState(() {
      position = res;
      _child = mapWidget();
      getAddress(position.latitude, position.longitude);
    });
  }


  getAddress(double lat, double long) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
    setState(() {
      place = placemarks[0] ;
      _currentAddress = "${place.subLocality}, ${place.subAdministrativeArea}, ${place.administrativeArea}" ;
      print("$_currentAddress");
    });
  }


  Widget mapWidget(){
    return GoogleMap(
      markers: _createMarker(),
      myLocationEnabled: true,
      initialCameraPosition: CameraPosition(
      target: LatLng(position.latitude, position.longitude),
      zoom: 16.0,
    ),
      onMapCreated: (GoogleMapController controller){
        _mapController = controller;
      },
    );
  }

  Set<Marker> _createMarker(){
    return<Marker>[
      Marker(
        markerId: MarkerId("mylocation"),
        position: LatLng(position.latitude, position.longitude),
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(title: "My Location")
      )
    ].toSet();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.blueAccent, width: 4),
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 3,
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
              bottomRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
            ),
            child: _child,
          ),
        ),

    );
  }


}
