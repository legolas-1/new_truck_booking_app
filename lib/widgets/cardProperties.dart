import 'package:flutter/material.dart';

class DetailCard extends StatelessWidget {
  String productType;
  String loadingPoint;
  String unloadingPoint;
  String truckPreference;
  String noOfTrucks;
  String weight;
  bool isPending;
  String comments;
  bool isCommentsEmpty;

  DetailCard(
      {this.loadingPoint,
      this.unloadingPoint,
      this.productType,
      this.truckPreference,
      this.noOfTrucks,
      this.weight,
      this.isPending,
      this.comments,
      this.isCommentsEmpty});

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
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  border: Border.symmetric(
                    horizontal: BorderSide(
                      color: Colors.grey,
                      width: 0.5,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/load.jpeg'),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Column(
                      children: [
                        Text(
                          'From $loadingPoint',
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          'To $unloadingPoint',
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$noOfTrucks $truckPreference',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        '$productType',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        'Upto $weight tons ',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 85,
                    width: 85,
                    alignment: Alignment.centerRight,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                'assets/${truckPreference.toLowerCase()}.jpeg'),
                            fit: BoxFit.cover)),
                  ),
                ],
              ),
              SizedBox(
                height: 3,
              ),
              isCommentsEmpty
                  ? Container()
                  : Container(
                      child: Text(
                        'Comments : $comments ',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

//TODO: remove commented code.

//
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
