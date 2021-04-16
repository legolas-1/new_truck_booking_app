// To parse this JSON data, do

//     final cardsModal = cardsModalFromJson(jsonString);
import 'dart:convert';

CardsModal cardsModalFromJson(String str) => CardsModal.fromJson(json.decode(str));

String cardsModalToJson(CardsModal data) => json.encode(data.toJson());

class GpsDataModel{
  String speed;
  double lat;
  double lng;
  String imei;
  String deviceName;
  String powerValue;
  GpsDataModel({this.speed, this.imei, this.lat, this.deviceName, this.lng, this.powerValue});
}


class CardsModal {
  CardsModal({
    this.id,
    this.ownerId,
    this.loadingPoint,
    this.unloadingPoint,
    this.productType,
    this.truckType,
    this.noOfTrucks,
    this.weight,
    this.comment,
    this.status,
  });

  String id;
  dynamic ownerId;
  String loadingPoint;
  String unloadingPoint;
  String productType;
  String truckType;
  String noOfTrucks;
  String weight;
  String comment;
  String status;

  factory CardsModal.fromJson(Map<String, dynamic> json) => CardsModal(
    id: json["id"],
    ownerId: json["ownerId"],
    loadingPoint: json["loadingPoint"],
    unloadingPoint: json["unloadingPoint"],
    productType: json["productType"],
    truckType: json["truckType"],
    noOfTrucks: json["noOfTrucks"],
    weight: json["weight"],
    comment: json["comment"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "ownerId": ownerId,
    "loadingPoint": loadingPoint,
    "unloadingPoint": unloadingPoint,
    "productType": productType,
    "truckType": truckType,
    "noOfTrucks": noOfTrucks,
    "weight": weight,
    "comment": comment,
    "status": status,
  };
}

// import 'dart:convert';
//
// CardsModal cardsModalJson(String values) =>
//     CardsModal.fromJson(json.decode(values));
//
// String cardsModalToJson(CardsModal data) => json.encode(data.toJson());
//
// class CardsModal {
//   String loadingPoint;
//   String unloadingPoint;
//   String productType;
//   String truckType;
//   String noOfTrucks;
//   String weight;
//   String comment;
//   String status;
//
//   CardsModal(
//       {this.loadingPoint,
//       this.unloadingPoint,
//       this.productType,
//       this.truckType,
//       this.noOfTrucks,
//       this.weight,
//       this.comment,
//       this.status});
//
//   factory CardsModal.fromJson(Map<String, dynamic> json) => CardsModal(
//         loadingPoint: json["loadingPoint"],
//         unloadingPoint: json["unloadingPoint"],
//         productType: json["productType"],
//         truckType: json["truckType"],
//         noOfTrucks: json["noOfTrucks"],
//         weight: json["weight"],
//         comment: json["comment"],
//         status: json["status"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "loadingPoint": loadingPoint,
//         "unloadingPoint": unloadingPoint,
//         "productType": productType,
//         "truckType": truckType,
//         "noOfTrucks": noOfTrucks,
//         "weight": weight,
//         "comment": comment,
//         "status": status,
//       };
//
//   String get loadingpoint => loadingPoint;
//
//   String get unloadingpoint => unloadingPoint;
//
//   String get producttype => productType;
//
//   String get trucktype => truckType;
//
//   String get nooftrucks => noOfTrucks;
//
//   String get weights => weight;
//
//   String get comments => comment;
//
//   String get statuss => status;
// }

//
//
// class DetailPage extends StatelessWidget {
//   CardsModal employee;
//
//   DetailPage(this.employee);
//
//   // deleteEmployee1(CardsModal employee) async {
//   //   final url = Uri.parse('http://localhost:8080/deleteemployee');
//   //   final request = http.Request("DELETE", url);
//   //   request.headers
//   //       .addAll(<String, String>{"Content-type": "application/json"});
//   //   request.body = jsonEncode(employee);
//   //   final response = await request.send();
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(employee.loadingPoint),
//         actions: <Widget>[
//           IconButton(
//               icon: Icon(
//                 Icons.edit,
//                 color: Colors.white,
//               ),
//               onPressed: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => updateEmployee(employee)));
//               })
//         ],
//       ),
//       body: Container(
//         child: Text('FirstName' +
//             ' ' +
//             employee.loadingPoint+
//             ' ' +
//             'LastName' +
//             employee.unloadingPoint),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           deleteEmployee1(employee);
//           Navigator.push(context,
//               MaterialPageRoute(builder: (context) => deleteEmployee()));
//         },
//         child: Icon(Icons.delete),
//         backgroundColor: Colors.pink,
//       ),
//     );
//   }
// }
