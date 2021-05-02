import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:Liveasy/screens/shipper_new_entry.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoactionCardsModal {
  String placeName;
  String placeAddress;
  LoactionCardsModal({this.placeName, this.placeAddress});
}

class LoadingPointSearchScreen extends StatefulWidget {
  LoadingPointSearchScreen({this.value, this.city});
  String value;
  String city;
  @override
  _LoadingPointSearchScreenState createState() =>
      _LoadingPointSearchScreenState();
}

class _LoadingPointSearchScreenState extends State<LoadingPointSearchScreen> {
  var LoacationCards;
  Future<List<LoactionCardsModal>> fillCityName(String cityName) async {
    if (cityName.length > 1) {
      //TODO: remove print statements for whole code !!!
      print('abc');

      //TODO: below you are using client_secret and client_id to make a call.
      // Put these two in a global store !! and use them from there.
      // url will look like this, why did that ? because anyone will be able to get this client by reversing code of app and exploit the API and API will ban the client which will stop the app for everyone.
      // also if will ever change this to new client you will have to change this url everywhere by hand. think of 1000s of files and changing this varibale ??
      // that's why we will keep it as an variable in global state and if it changes 1000s will update automatically
      // https://outpost.mapmyindia.com/api/security/oauth/token?grant_type=client_credentials&client_id=$client_id==&client_secret=$client_serect
      http.Response tokenGet = await http.post(
          'https://outpost.mapmyindia.com/api/security/oauth/token?grant_type=client_credentials&client_id=33OkryzDZsJmp0siGnK04TeuQrg3DWRxswnTg_VBiHew-2D1tA3oa3fthrGnx4vwbwlbF_xT2T4P9dykuS1GUNmbRb8e5CUgz-RgWDyQspeDCXkXK5Nagw==&client_secret=lrFxI-iSEg9xHXNZXiqUoprc9ZvWP_PDWBDw94qhrze0sUkn7LBDwRNFscpDTVFH7aQT4tu6ycN0492wqPs-ewpjObJ6xuR7iRufmSVcnt9fys5dp0F5jlHLxBEj7oqq');
      var body = jsonDecode(tokenGet.body);
      var token = body["access_token"];
      http.Response response1 = await http.get(
        'https://atlas.mapmyindia.com/api/places/search/json?query=$cityName&pod=CITY',
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
      );
      print(response1.statusCode);
      var adress = (jsonDecode(response1.body));
      adress = adress["suggestedLocations"];
      List<LoactionCardsModal> card = [];
      for (var json in adress) {
        LoactionCardsModal loactionCardsModal = new LoactionCardsModal();
        loactionCardsModal.placeName = json["placeName"];
        loactionCardsModal.placeAddress = json["placeAddress"];
        card.add(loactionCardsModal);
      }
      return card;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3F2F1),
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          //TODO: why are we using Icons ? if we using material ui ? pick one and also make
          //same _icons.dart file and define all of them there and use them from there.
          child: Icon(Icons.arrow_back_ios, size: 25),
        ),
        title: Text(
          'Shipping Details',
          //TODO: put alingment in _texts.dart file too.
          textAlign: TextAlign.center,
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 72,
            child: TextFormField(
              autofocus: true,
              //onFieldSubmitted: (String value){ Provider.of<NewDataByShipper>(context, listen: false).updateLoadingPoint(newValue:value.trim());} ,
              onChanged: (newValue) {
                print(newValue);
                setState(() {
                  LoacationCards = fillCityName(newValue);
                });
                //Provider.of<NewDataByShipper>(context, listen: false).updateLoadingPoint(newValue: newValue.trim());

                print(newValue);
              },
              //onSaved: (value){Provider.of<NewDataByShipper>(context, listen: false).updateLoadingPoint(newValue: value.trim());},
              decoration: InputDecoration(
                hintText: widget.value,
                hintStyle: TextStyle(fontSize: 20, color: Colors.grey),
              ),
              validator: (String value) {
                if (value.trim().isEmpty) {
                  return 'Loading Point is Required';
                } else
                  return null;
              },
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: FutureBuilder(
                future: LoacationCards,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Container(
                      child: Center(
                        child: SpinKitDoubleBounce(
                          color: Colors.blue,
                          size: 40,
                        ),
                      ),
                    );
                  }
                  return Expanded(
                    child: ListView.builder(
                        reverse: false,
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) => buildCard(
                            placeName: snapshot.data[index].placeName,
                            placeAddress: snapshot.data[index].placeAddress,
                            context: context)),
                  );
                }),
          ),
        ],
      ),
    );
  }

  GestureDetector buildCard(
      {BuildContext context, String placeName, String placeAddress}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ShipperNewEntryScreen(
              userCity: placeName,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(3),
        child: Text(
          '$placeName ($placeAddress)',
          style: TextStyle(fontSize: 13),
        ),
      ),
    );
  }
}
