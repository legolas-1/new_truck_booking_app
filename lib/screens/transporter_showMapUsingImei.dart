import 'dart:io';

import 'package:Liveasy/widgets/backend_connection.dart';
import 'package:geocoder/geocoder.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
String mapKey = "AIzaSyCTVVijIWofDrI6LpSzhUqJIF90X-iyZmE";

// ignore: must_be_immutable
class ShowMapWithImei extends StatefulWidget {
  GpsDataModel gpsData;
  ShowMapWithImei({this.gpsData});
  @override
  _ShowMapWithImeiState createState() => _ShowMapWithImeiState();
}

class _ShowMapWithImeiState extends State<ShowMapWithImei> {
  @override
  void initState() {
    super.initState();
    getAddress();
  }
  String address = "";
  getMarkerAtInputPosition() {
    Position inputPosition = Position(latitude: widget.gpsData.lat, longitude: widget.gpsData.lng);
    LatLng coordinates = LatLng(inputPosition.latitude, inputPosition.longitude);
    showMarkerAtPosition(inputPosition, 'imeiLocation');
    CameraPosition cameraPosition = CameraPosition(target: coordinates, zoom: 12);
    googleMapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition),);
  }
  void getAddress()async{
    var addresses = await Geocoder.local.findAddressesFromCoordinates(Coordinates(widget.gpsData.lat, widget.gpsData.lng));
    var first = addresses.first;
    print(first.addressLine);
    http.Response tokenGet = await http.post('https://outpost.mapmyindia.com/api/security/oauth/token?grant_type=client_credentials&client_id=33OkryzDZsJmp0siGnK04TeuQrg3DWRxswnTg_VBiHew-2D1tA3oa3fthrGnx4vwbwlbF_xT2T4P9dykuS1GUNmbRb8e5CUgz-RgWDyQspeDCXkXK5Nagw==&client_secret=lrFxI-iSEg9xHXNZXiqUoprc9ZvWP_PDWBDw94qhrze0sUkn7LBDwRNFscpDTVFH7aQT4tu6ycN0492wqPs-ewpjObJ6xuR7iRufmSVcnt9fys5dp0F5jlHLxBEj7oqq');
    print(tokenGet.statusCode);
    print(tokenGet.body);
    var body = jsonDecode(tokenGet.body);
    var token = body["access_token"];
    http.Response response = await http.get('https://atlas.mapmyindia.com/api/places/geocode?address=${first.addressLine}',
      headers: {HttpHeaders.authorizationHeader: "$token"},);
    print(response.statusCode);
    print(response.body);
    var adress = jsonDecode(response.body);
    print(adress);
    var street = adress["copResults"]["street"] == null || adress["copResults"]["street"] == ""  ? "": "${adress["copResults"]["street"]}, ";
    var locality = adress["copResults"]["locality"] == null || adress["copResults"]["locality"] == "" ? "": "${adress["copResults"]["locality"]}, ";
    var cityName = adress["copResults"]["city"];
    var stateName = adress["copResults"]["state"];
    setState(() {
      address = "$street$locality$cityName, $stateName";
    });
  }

  var geolocator = Geolocator();
  PolylinePoints polylinePoints;
  List<LatLng> polylineCoordinates = [];
  Map<PolylineId, Polyline> polylines = {};
  Set<Marker> markers = {};
  Position myLocation;
  Position finalPosition;

  _createPolylines(Position start, Position destination) async {
    polylinePoints = PolylinePoints();
    // PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
    //   mapKey, // Google Maps API Key
    //   PointLatLng(start.latitude, start.longitude),
    //   PointLatLng(destination.latitude, destination.longitude),
    //   travelMode: TravelMode.transit,
    // );
    // print(result.status);
    // print(result.errorMessage);
    // print(result.points);

    http.Response response= await http.get('https://apis.mapmyindia.com/advancedmaps/v1/5ug2mtejb2urr2zwgdg8l8mh3zdtm2i3/route_adv/driving/${start.longitude},${start.latitude};${destination.longitude},${destination.latitude}');
    var body = jsonDecode(response.body);
    print(body["routes"][0]["geometry"]);
    List<PointLatLng> polylinePoint = polylinePoints.decodePolyline(body["routes"][0]["geometry"]);
    String distanceBetween = body["routes"][0]["distance"].toString();
    print(distanceBetween);
    print(polylinePoint);
    // Adding the coordinates to the list
    if (polylinePoint.length != 0) {
      polylinePoint.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    PolylineId id = PolylineId('poly');
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.blue,
      points: polylineCoordinates,
      width: 5,
    );
    setState(() {
      polylines[id] = polyline;
    });
  }

  void showMarkerAtPosition(Position position, String markerID)async{
    Marker newMarker = Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      markerId: MarkerId(markerID),
      position: LatLng(
        position.latitude,
        position.longitude,
      ),
    );
    setState(() {
      markers.add(newMarker);
    });
  }

  void getCurrentLocation() async {
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
    LatLng coordinates = LatLng(position.latitude, position.longitude);
    print(coordinates);
    myLocation = Position(latitude:position.latitude, longitude: position.longitude);
    CameraPosition cameraPosition = CameraPosition(target: coordinates, zoom: 12);
     googleMapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition),);//camera moved to user's position
    // http.Response response = await http.get('http://apis.mapmyindia.com/advancedmaps/v1/5ug2mtejb2urr2zwgdg8l8mh3zdtm2i3/rev_geocode?lat=${position.latitude}&lng=${position.longitude}');
    // var body = jsonDecode(response.body);//gives address
    // print(body["results"][0]["locality"]);
    // print(body["results"][0]);

      showMarkerAtPosition(myLocation, "myPosition");
   var pos = Position(longitude: widget.gpsData.lng, latitude: widget.gpsData.lat);
     _createPolylines(position, pos);
  }
  Completer<GoogleMapController> _controllerGoogleMap = Completer();

  GoogleMapController googleMapController;
  CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(28.6139383, 77.20902000000001),
    zoom: 14,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GestureDetector(
        onTap: (){FocusScope.of(context).unfocus();},
        child: Scaffold(
          body: SafeArea(
            child: Container(
              color: Color(0xFFF3F2F1),
              child: Column(mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Row(
                          children: [

                            Container(
                              width : 250,
                              child: Text(address, style: TextStyle(fontSize: 18),),
                            ),
                            Text(widget.gpsData.speed, style: TextStyle(fontSize: 50),),
                            Text("km/hr", style: TextStyle(fontSize: 13),)
                          ],
                        ),

                      ),
                    ],
                  ),
                  Expanded(
                    child: GoogleMap(
                       polylines: Set.from(polylines.values),
                      markers:  markers,
                      mapType: MapType.normal,
                      initialCameraPosition: _initialCameraPosition,
                      onMapCreated: (GoogleMapController controller){
                        _controllerGoogleMap.complete(controller);
                        googleMapController = controller;
                        getMarkerAtInputPosition();
                        getCurrentLocation();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<String> getLocationByImei({String imei}) async {
  var jsonData;
  http.Response response = await http.get("http://65.2.59.24:3000/locationbyimei/$imei");
  jsonData = await jsonDecode(response.body);
  print(response.statusCode);
  print(jsonData);
  return response.body.toString();
}