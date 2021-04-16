import 'package:flutter/material.dart';

class TruckDetailsCard extends StatelessWidget {
  String imei;
  String mobileNum;

  TruckDetailsCard(
      {this.imei,this.mobileNum});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        color: Color(0xFFF3F2F1),
        elevation: 10,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
          padding: EdgeInsets.only(top: 1, bottom: 8, left: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(imei, style: TextStyle(fontSize: 18,),),
              SizedBox(
                height: 3,
              ),
              Text(mobileNum, style: TextStyle(fontSize: 18,),),
            ],
          ),
        ),
      ),
    );
  }
}

//style: TextStyle(
//                     fontSize: 18,
//                   ),
//
// class TasksData extends ChangeNotifier {
//   List<CardTile> cards = [];
//
//   void addTasks(
//       String productType,
//       String loadingPoint,
//       String unloadingPoint,
//       String truckPreference,
//       String noOfTrucks,
//       String weight,
//       bool isPending,
//       String comments,
//       bool isCommentsEmpty,
//       ) {
//     cards.add(CardTile(
//         loadingPoint: loadingPoint,
//         unloadingPoint: unloadingPoint,
//         productType: productType,
//         truckPreference: truckPreference,
//         noOfTrucks: noOfTrucks,
//         weight: weight,
//         isPending: isPending,
//         comments: comments,
//         isCommentsEmpty: isCommentsEmpty));
//     notifyListeners();
//   }
// }
// //
// class MyAlertDialog extends StatelessWidget {
//   final String title;
//   final String content;
//   final List<Widget> actions;
//
//   MyAlertDialog({
//     this.title,
//     this.content,
//     this.actions = const [],
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text(
//         this.title,
//         style: Theme.of(context).textTheme.title,
//       ),
//       actions: this.actions,
//       content: Text(
//         this.content,
//         style: Theme.of(context).textTheme.body1,
//       ),
//     );
//   }
// }
