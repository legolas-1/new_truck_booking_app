import 'package:Liveasy/screens/choice_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location_permissions/location_permissions.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:Liveasy/widgets/backend_connection.dart';
import 'package:Liveasy/widgets/cardProperties.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:Liveasy/widgets/weight_modal_screen.dart';
import 'package:Liveasy/widgets/noOfTrucks_modal_screen.dart';
import 'package:Liveasy/widgets/providerData.dart';
import 'package:Liveasy/widgets/dropDownGenerator.dart';
import 'package:Liveasy/widgets/product_type_modal_screen.dart';
import 'package:Liveasy/widgets/truck_type_modal_screen.dart';
import 'package:Liveasy/widgets/functionsAndModels.dart';
String mapKey = "AIzaSyCTVVijIWofDrI6LpSzhUqJIF90X-iyZmE";

var controller1 = TextEditingController();
var controller2 = TextEditingController();
var controller3 = TextEditingController();

// ignore: must_be_immutable
class ShipperHomeScreen extends StatefulWidget {
  User user;
  String userCity ='';
  ShipperHomeScreen({this.user, this.userCity});
  @override
  _ShipperHomeScreenState createState() => _ShipperHomeScreenState();
}

class _ShipperHomeScreenState extends State<ShipperHomeScreen> {
  var locationCard1;
  var locationCard2;
  String city = '';
  DateTime date = DateTime.now();
  int currentPage = 0;
  PageController _controller = PageController(initialPage: 0,);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();


  Future<CardsModal> createCardOnApi() async {
    Map data = {
      "loadingPoint": Provider.of<NewDataByShipper>(context, listen: false).loadingPoint,
      "unloadingPoint": Provider.of<NewDataByShipper>(context, listen: false).unloadingPoint,
      "productType": Provider.of<NewDataByShipper>(context, listen: false).productType,
      "truckType": Provider.of<NewDataByShipper>(context, listen: false).truckPreference,
      "noOfTrucks": Provider.of<NewDataByShipper>(context, listen: false).noOfTrucks,
      "weight": Provider.of<NewDataByShipper>(context, listen: false).weight,
      "comment": Provider.of<NewDataByShipper>(context, listen: false).isCommentsEmpty ? '' : Provider.of<NewDataByShipper>(context, listen: false).comments
    };
    String body = json.encode(data);
    final String apiUrl = "http://ec2-52-53-40-46.us-west-1.compute.amazonaws.com:8080/load";
    final response = await http.post(apiUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body);
    Provider.of<NewDataByShipper>(context,listen: false).clearAll();
    ProductTypeWidgetScreen().clear_all();
    TruckTypeWidgetScreen().clear_all();
    WeightWidgetScreen().clear_all();
    controller1.clear();
    controller2.clear();
    controller3.clear();
    print(response.statusCode);
    if (response.statusCode == 200) {
      final String responseString = response.body;
      return cardsModalFromJson(responseString);
    } else {
      return null;
    }
  }

  void getDate(BuildContext context) async {
    DateTime pickedDate = await showDatePicker(
        context: context, initialDate: date, firstDate: DateTime.now(), lastDate: DateTime(DateTime.now().year, DateTime.now().month, 31));
    if(pickedDate !=null){
      setState(() {
        date = pickedDate;
      });
    }
  }

  Future<List<CardsModal>> getCardsData() async {
    var jsonData;
    http.Response response = await http.get("http://ec2-52-53-40-46.us-west-1.compute.amazonaws.com:8080/load");
    jsonData = await jsonDecode(response.body);
    print(jsonData);
    List<CardsModal> card = [];
    for (var json in jsonData) {
      CardsModal cardsModal = new CardsModal();
      cardsModal.loadingPoint = json["loadingPoint"];
      cardsModal.unloadingPoint = json["unloadingPoint"];
      cardsModal.productType = json["productType"];
      cardsModal.truckType = json["truckType"];
      cardsModal.noOfTrucks = json["noOfTrucks"];
      cardsModal.weight = json["weight"];
      cardsModal.comment = json["comment"];
      cardsModal.status = json["status"];
      card.add(cardsModal);
    }
    return card;
  }

  void getCurrentLocation() async {

    if (city == ''){
    PermissionStatus permission1 =
        await LocationPermissions().checkPermissionStatus();
    if (permission1 != PermissionStatus.granted){
      permission1 = await LocationPermissions().requestPermissions();
    }

    var position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position.latitude);
    print(position);
    final coordinates = new Coordinates(position.latitude, position.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
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
    var cityName = adress["copResults"]["city"];
    var stateName = adress["copResults"]["state"];
    city = '$cityName ($stateName)';
    print(city);
    controller1 = TextEditingController(text: city);
    Provider.of<NewDataByShipper>(context,listen: false).updateLoadingPoint(newValue: city);
  }
  else { city = widget.userCity;
  controller1 = TextEditingController(text: city);
    Provider.of<NewDataByShipper>(context,listen: false).updateLoadingPoint(newValue: city);}
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }
  @override
  Widget build(BuildContext context) {
    if (Provider.of<NewDataByShipper>(context).loadingPoint != null){
      controller1 = TextEditingController(text:(Provider.of<NewDataByShipper>(context).loadingPoint));}
    if (Provider.of<NewDataByShipper>(context).unloadingPoint != null){
      controller2 = TextEditingController(text:(Provider.of<NewDataByShipper>(context).unloadingPoint));}
    return MaterialApp(
      theme: ThemeData.light(),
      home: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          drawer: Container(
            width: 250,
            child: Drawer(
              child: ListView(
                children: [
                  Container(
                    height: 150,
                    child: DrawerHeader(
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            child: Icon(Icons.home),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            widget.user == null
                                ? '+911234567891'
                                : widget.user.phoneNumber,
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      FirebaseAuth.instance.signOut();

                      Navigator.pushAndRemoveUntil(
                          context,  MaterialPageRoute(builder: (context) => ChoiceScreen()), (route) => false);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: ListTile(
                        title: Text(
                          'Sign Out',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        trailing: Icon(
                          Icons.exit_to_app,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          backgroundColor: Color(0xFFF3F2F1),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 100,
                  decoration: BoxDecoration(
                    color: Color(0xFF525252),
                    border: Border.all(color: Colors.black, width: 1),
                    //borderRadius: BorderRadius.only(bottomRight: Radius.circular(19),bottomLeft: Radius.circular(19),),
                  ),
                  padding: EdgeInsets.only(bottom: 10, top: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 25,),
                          Container(
                            child: GestureDetector(
                                onTap: (){
                                  _scaffoldKey.currentState.openDrawer();
                                },
                                child: Icon(Icons.list, size: 30,color: Colors.white,)),
                          ),
                          SizedBox(width: 20,),
                          Container(
                            child: Text('LiveEasy', style: TextStyle(fontSize: 23, color: Colors.white, fontWeight: FontWeight.bold),),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Container(
                        height: 27,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                        children: [
                          SizedBox(width: 25,),
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: currentPage == 0 ? Colors.white30: Color(0xFF525252),
                              borderRadius: BorderRadius.circular(19),
                            ),
                            child: GestureDetector(
                              onTap: (){
                                _controller.jumpToPage(0);
                              },
                              child: Text('HOME', style: TextStyle(fontSize: 15, color: Colors.white),),
                              // child: Icon(
                              //   Icons.home,
                              //   size: 40,
                              //   color: currentPage == 0 ? Colors.blue: Colors.black,
                              // ),
                            ),
                          ),
                          SizedBox(width: 30,),
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: currentPage == 1 ? Colors.white30: Color(0xFF525252),
                              borderRadius: BorderRadius.circular(19),
                            ),
                            child: GestureDetector(
                              onTap: (){
                                _controller.jumpToPage(1);
                              },
                              child: Text('ADD LOAD', style: TextStyle(fontSize: 15, color: Colors.white),),
                              // child: Icon(
                              //   Icons.add,
                              //   color: currentPage == 1 ? Colors.blue: Colors.black,
                              //   size: 40,
                              // ),
                            ),
                          ),
                          SizedBox(width: 30,),
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: currentPage == 2 ? Colors.white30: Color(0xFF525252),
                              borderRadius: BorderRadius.circular(19),
                            ),
                            child: GestureDetector(
                            onTap: (){
                              _controller.jumpToPage(2);
                            },
                              child: Text('LIST', style: TextStyle(fontSize: 15, color: Colors.white),),
                              // child: Icon(
                            //   Icons.list,
                            //   color: currentPage == 2 ? Colors.blue: Colors.black,
                            //   size: 40,
                            // ),
                          ),
                          ),
                        ],
                        ),
                      ),
                    ],
                  )
              ),
              Expanded(
                child: PageView(
                  onPageChanged: (val) {
                    setState(() {
                      currentPage = val;
                    });
                  },
                  controller: _controller,
                  children: [
                    Scaffold(
                          backgroundColor: Color(0xFFF3F2F1),
                          body: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: (){
                                },
                                child: Text(
                                  '           Welcome To \n The Truck Booking App',
                                  style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ),
                    Scaffold(
                      backgroundColor: Color(0xFFF3F2F1),
                      body: Form(
                        key: formKey,
                        autovalidateMode: AutovalidateMode.always,
                        onChanged: () {
                          Form.of(primaryFocus.context).save();
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(left: 20, right: 20, bottom: 10,top: 20),
                                child: Container(
                                  color: Color(0xFFF3F2F1),
                                  child: ListView(
                                    keyboardDismissBehavior:
                                    ScrollViewKeyboardDismissBehavior.onDrag,
                                    children: [
                                      Container(
                                        height: 50,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Expanded(
                                              child: TextFormField(
                                                keyboardType: TextInputType.streetAddress,
                                                controller: controller1,
                                                onChanged: (newValue) {
                                                  if(newValue.length > 2){print(newValue);
                                                  setState(() {
                                                    locationCard1 = fillCityName(newValue);
                                                  });}
                                                  else{
                                                    setState(() {
                                                      locationCard1 = null;
                                                    });
                                                  }
                                                },
                                                onFieldSubmitted: (String value){ Provider.of<NewDataByShipper>(context, listen: false).updateLoadingPoint(newValue:value.trim());} ,
                                                decoration: InputDecoration(
                                                  hintText: 'Loading Point',
                                                  hintStyle:
                                                  TextStyle(fontSize: 20, color: Colors.grey),
                                                ),
                                                validator: (String value) {
                                                  if (value.trim().isEmpty) {
                                                    return 'Loading Point is Required';
                                                  } else
                                                    return null;
                                                },
                                                style:
                                                TextStyle(fontSize: 20, color: Colors.black),
                                              ),
                                            ),
                                            Container(
                                              child: GestureDetector(onTap:(){setState(() {
                                                Provider.of<NewDataByShipper>(context,listen: false).updateLoadingPoint(newValue: null);
                                                locationCard1 = null;
                                                controller1 = TextEditingController(text: null);
                                              });} ,child: Icon(Icons.clear,size: 25, color: Colors.black26,)),
                                            )
                                          ],
                                        ),
                                      ),
                                      locationCard1 == null ? Container(): SizedBox(height: 20,),
                                      locationCard1 != null ? Container(
                                        height: 150,
                                        child: FutureBuilder(
                                            future: locationCard1,
                                            builder: (BuildContext context,  AsyncSnapshot snapshot ){
                                              if (snapshot.data == null) {
                                                return Container(
                                                  child: Center(
                                                    child: SpinKitDoubleBounce(
                                                      color: Colors.blue,
                                                      size: 20,
                                                    ),),
                                                );
                                              }
                                              return ListView.builder(
                                                  reverse: false,
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                  ),
                                                  itemCount: snapshot.data.length,
                                                  itemBuilder: (context, index) => buildCard(
                                                      placeName: snapshot.data[index].placeName,
                                                      placeAddress: snapshot.data[index].placeAddress,
                                                      CardType: 'loading',
                                                      context: context)
                                              );}),) : Container(),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        height: 72,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Expanded(
                                              child: TextFormField(
                                                keyboardType: TextInputType.streetAddress,
                                                controller: controller2,
                                                onChanged: (newValue) {
                                                  if(newValue.length > 2){print(newValue);
                                                  setState(() {
                                                    locationCard2 = fillCityName(newValue);
                                                  });}
                                                  else{
                                                    setState(() {
                                                      locationCard2 = null;
                                                    });
                                                  }
                                                },
                                                onFieldSubmitted: (String value){ Provider.of<NewDataByShipper>(context, listen: false).updateUnloadingPoint(newValue:value.trim());} ,
                                                decoration: InputDecoration(
                                                  hintText: 'Unloading Point',
                                                  hintStyle:
                                                  TextStyle(fontSize: 20, color: Colors.grey),
                                                ),
                                                validator: (String value) {
                                                  if (value.trim().isEmpty) {
                                                    return 'Unloading Point is Required';
                                                  } else
                                                    return null;
                                                },
                                                style:
                                                TextStyle(fontSize: 20, color: Colors.black),
                                              ),
                                            ),
                                            Container(
                                              child: GestureDetector(onTap:(){setState(() {
                                                Provider.of<NewDataByShipper>(context,listen: false).updateUnloadingPoint(newValue: null);
                                                locationCard2 = null;
                                                controller2= TextEditingController(text: null);
                                              });} ,child: Icon(Icons.clear, size: 25, color: Colors.black26,)),
                                            )
                                          ],
                                        ),
                                      ),
                                      locationCard2 == null ? Container(): SizedBox(height: 20,),
                                      locationCard2 != null ? Container(
                                        height: 150,
                                        child: FutureBuilder(
                                            future: locationCard2,
                                            builder: (BuildContext context,  AsyncSnapshot snapshot ){
                                              if (snapshot.data == null) {
                                                return Container(
                                                  child: Center(
                                                    child: SpinKitDoubleBounce(
                                                      color: Colors.blue,
                                                      size: 20,
                                                    ),),
                                                );
                                              }
                                              return ListView.builder(
                                                  reverse: false,
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                  ),
                                                  itemCount: snapshot.data.length,
                                                  itemBuilder: (context, index) => buildCard(
                                                    placeName: snapshot.data[index].placeName,
                                                    placeAddress: snapshot.data[index].placeAddress,
                                                    CardType: 'unloading',
                                                    context: context,)
                                              );}),) : Container(),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          FocusScope.of(context).unfocus();
                                          showDialog(context: context, builder: (context)=> ProductTypeWidgetScreen());
                                        },
                                        child: Container(
                                          height: 62,
                                          child: DropDownGenerator(
                                            dropdownValue: 'Product Type',
                                            dropdownValues: [],
                                            hintText: Provider.of<NewDataByShipper>(context).productType== null
                                                ? 'Product Type'
                                                :  Provider.of<NewDataByShipper>(context).productType,
                                            notAllowedValue: 'Product Type',
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          FocusScope.of(context).unfocus();
                                          showDialog(context: context, builder: (context)=> TruckTypeWidgetScreen());
                                        },
                                        child: Container(
                                          height: 62,
                                          child: DropDownGenerator(
                                            dropdownValue: 'Truck Preference',
                                            dropdownValues: [],
                                            hintText: Provider.of<NewDataByShipper>(context).truckPreference== null
                                                ? 'Truck Preference'
                                                :  Provider.of<NewDataByShipper>(context).truckPreference,
                                            notAllowedValue: 'Truck Preference',
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        height: 62,
                                        child: Row(
                                          children: [
                                            Text(
                                              'No. Of Trucks                                 ',
                                              style: TextStyle(
                                                  fontSize: 18, color: Colors.grey),
                                            ),
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: () {
                                                  FocusScope.of(context).unfocus();
                                                  showDialog(context: context, builder: (context)=> NoOfTrucksWidgetScreen());
                                                },
                                                child: Container(
                                                  height: 72,
                                                  child: DropDownGenerator(
                                                    dropdownValue: 'No Of Trucks',
                                                    dropdownValues: [],
                                                    hintText: Provider.of<NewDataByShipper>(context).noOfTrucks== '1'
                                                        ? '1'
                                                        :  Provider.of<NewDataByShipper>(context).noOfTrucks,
                                                    notAllowedValue:'No Of Trucks' ,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              FocusScope.of(context).unfocus();
                                              showDialog(context: context, builder: (context)=>WeightWidgetScreen());
                                            },
                                            child: Container(
                                              height: 72,
                                              width: 180,
                                              child: DropDownGenerator(
                                                dropdownValue: 'Weight(In Tons)',
                                                dropdownValues: [],
                                                hintText: Provider.of<NewDataByShipper>(context).weight== null
                                                    ? 'Weight (In Tons)'
                                                    :  Provider.of<NewDataByShipper>(context).weight,
                                                notAllowedValue: 'Weight (In Tons)',
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 5,),
                                          GestureDetector(
                                            onTap: () {
                                              getDate(context);
                                            },
                                            child: Container(
                                                height: 72,
                                                width: 120,
                                                child: DatePickerGenerator(date: '${date.day.toString()}-${date.month.toString()}-${date.year.toString()}' ,)
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        height: 72,
                                        child: TextField(
                                          controller: controller3,
                                          onChanged: (newValue) {
                                            Provider.of<NewDataByShipper>(context, listen: false).updateComments(newValue: newValue);
                                          },
                                          decoration: InputDecoration(
                                            hintText: 'Comments',
                                            hintStyle:
                                            TextStyle(fontSize: 20, color: Colors.grey),
                                          ),
                                          style:
                                          TextStyle(fontSize: 20, color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 70,
                              child: FlatButton(
                                onPressed: () async {
                                  if (!formKey.currentState.validate()) {
                                    return;
                                  }
                                  if (Provider.of<NewDataByShipper>(context,listen: false).loadingPoint == null){
                                    print('loading Point Null');
                                    throw 'Loading Point Null';
                                  }
                                  if (Provider.of<NewDataByShipper>(context,listen: false).unloadingPoint == null){
                                    print('Unloading Point Null');
                                    throw 'Unloading Point Null';
                                  }
                                  if (Provider.of<NewDataByShipper>(context, listen: false).productType == null){
                                    showDialog(context: context, builder: (context) => ProductTypeWidgetScreen());
                                  }
                                  else if (Provider.of<NewDataByShipper>(context, listen: false).truckPreference == null){
                                    showDialog(context: context, builder: (context) => TruckTypeWidgetScreen());
                                  }
                                  // else if (Provider.of<NewDataByShipper>(context, listen: false).noOfTrucks == null){
                                  //   showDialog(context: context, builder: (context) => NoOfTrucksWidgetScreen());
                                  // }
                                  else if (Provider.of<NewDataByShipper>(context, listen: false).weight == null){
                                    showDialog(context: context, builder: (context) => WeightWidgetScreen());
                                  }
                                  else{
                                    if (Provider.of<NewDataByShipper>(context, listen: false).comments != null) {
                                      if (Provider.of<NewDataByShipper>(context, listen: false).comments.isNotEmpty) {
                                        if (Provider.of<NewDataByShipper>(context, listen: false).comments != '') {
                                          Provider.of<NewDataByShipper>(context, listen: false).updateIsCommentsEmpty(newValue: false);
                                        } else {
                                          Provider.of<NewDataByShipper>(context, listen: false).updateIsCommentsEmpty(newValue: true);
                                        }
                                      } else {
                                        Provider.of<NewDataByShipper>(context, listen: false).updateIsCommentsEmpty(newValue: true);
                                      }
                                    } else {
                                      Provider.of<NewDataByShipper>(context, listen: false).updateIsCommentsEmpty(newValue: true);
                                    }
                                    try {
                                      final createdCard = await createCardOnApi();
                                      setState(() {
                                        _controller.jumpToPage(2);
                                      });

                                    } catch (e) {
                                      print(e);
                                    }}
                                },
                                color: Color(0xFF043979),
                                child: Text(
                                  'Submit',
                                  style: TextStyle(fontSize: 25, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Scaffold(
                          backgroundColor: Color(0xFFF3F2F1),
                          body: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: FutureBuilder(
                                    future: getCardsData(),
                                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                                      if (snapshot.data == null) {
                                        return Container(
                                          child: Center(
                                              child: SpinKitWave(
                                                color: Colors.lightBlueAccent,
                                                size: 60,
                                              )
                                          ),
                                        );
                                      }
                                      return ListView.builder(
                                        reverse: false,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10,
                                        ),
                                        itemCount: snapshot.data.length,
                                        itemBuilder: (context, index) => DetailCard(
                                          loadingPoint: snapshot.data[index].loadingPoint,
                                          unloadingPoint: snapshot.data[index].unloadingPoint,
                                          productType: snapshot.data[index].productType,
                                          truckPreference: snapshot.data[index].truckType,
                                          noOfTrucks: snapshot.data[index].noOfTrucks,
                                          weight: snapshot.data[index].weight,
                                          isPending: snapshot.data[index].status == 'pending'
                                              ? true
                                              : false,
                                          comments: snapshot.data[index].comment,
                                          isCommentsEmpty:
                                          snapshot.data[index].comment == '' ? true : false,
                                        ),
                                      );
                                    }),
                              ),
                            ],
                          ),
                        ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  GestureDetector buildCard({BuildContext context, String placeName, String placeAddress, String CardType}) {
    return GestureDetector(
      onTap: (){
        setState(() {
          if (CardType == 'loading'){
            locationCard1 = null;
            Provider.of<NewDataByShipper>(context,listen: false).updateLoadingPoint(newValue: '$placeName ($placeAddress)');}
          else if (CardType =='unloading'){
            locationCard2 = null;
            Provider.of<NewDataByShipper>(context,listen: false).updateUnloadingPoint(newValue: '$placeName ($placeAddress)');}
        });
      },
      child: Container(
        color: Color(0xFFF3F2F1),
        padding: EdgeInsets.all(3),
        child: Text('$placeName ($placeAddress)', style: TextStyle(fontSize: 15),),
      ),
    );
  }
}
