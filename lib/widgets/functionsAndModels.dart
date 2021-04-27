
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

// List of all items present:
//class LocationCardsModal
//Future<List<LocationCardsModal>> fillCityName(String cityName)

class LocationCardsModal {
  String placeName;
  String placeAddress;
  LocationCardsModal({this.placeName, this.placeAddress});
}
Future<List<LocationCardsModal>> fillCityName(String cityName) async {
  if (cityName.length > 0) {
    http.Response tokenGet = await http.post('https://outpost.mapmyindia.com/api/security/oauth/token?grant_type=client_credentials&client_id=33OkryzDZsJmp0siGnK04TeuQrg3DWRxswnTg_VBiHew-2D1tA3oa3fthrGnx4vwbwlbF_xT2T4P9dykuS1GUNmbRb8e5CUgz-RgWDyQspeDCXkXK5Nagw==&client_secret=lrFxI-iSEg9xHXNZXiqUoprc9ZvWP_PDWBDw94qhrze0sUkn7LBDwRNFscpDTVFH7aQT4tu6ycN0492wqPs-ewpjObJ6xuR7iRufmSVcnt9fys5dp0F5jlHLxBEj7oqq');
    var body = jsonDecode(tokenGet.body);
    var token = body["access_token"];
    http.Response response1 = await http.get('https://atlas.mapmyindia.com/api/places/search/json?query=$cityName&pod=CITY',
      headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},);
    print(response1.statusCode);
    var adress = (jsonDecode(response1.body));
    adress = adress["suggestedLocations"];
    List<LocationCardsModal> card = [];
    for ( var json in adress) {
      LocationCardsModal loactionCardsModal = new LocationCardsModal();
      loactionCardsModal.placeName = json["placeName"];
      loactionCardsModal.placeAddress = json["placeAddress"];
      card.add(loactionCardsModal);
    }
    card = card..sort((a,b) => a.placeName.toString().compareTo(b.placeName.toString()));
    return card;
  }
}

