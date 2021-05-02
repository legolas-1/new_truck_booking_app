import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Liveasy/widgets/providerData.dart';

//TODO: define all these in _colors.dart
//then make a new file which will be a json file.
//for all the conditions written below.
//
Color color_Unselected = Colors.white;
Color color_Selected = Colors.black45;
Color color_1 = color_Unselected;
Color color_2 = color_Unselected;
Color color_3 = color_Unselected;
Color color_4 = color_Unselected;
Color color_5 = color_Unselected;
Color color_6 = color_Unselected;
Color color_7 = color_Unselected;
Color color_8 = color_Unselected;
Color color_9 = color_Unselected;
Color color_10 = color_Unselected;

class NoOfTrucksWidgetScreen extends StatefulWidget {
  @override
  _NoOfTrucksWidgetScreenState createState() => _NoOfTrucksWidgetScreenState();
}

class _NoOfTrucksWidgetScreenState extends State<NoOfTrucksWidgetScreen> {
  void invert_all_colour(int cardNumber) {
    // TODO: make a file like which will on this condition
    // return you the selected color. and rest them will be unselected.
    // same in other file too - product_type_modal_screen
    if (cardNumber == 1 && color_1 == color_Unselected) {
      color_1 = color_Selected;
      color_2 = color_Unselected;
      color_3 = color_Unselected;
      color_4 = color_Unselected;
      color_5 = color_Unselected;
      color_6 = color_Unselected;
      color_7 = color_Unselected;
      color_8 = color_Unselected;
      color_9 = color_Unselected;
      color_10 = color_Unselected;
      Provider.of<NewDataByShipper>(context, listen: false)
          .updateNoOfTrucks(newValue: '1');
    } else if (cardNumber == 2 && color_2 == color_Unselected) {
      color_2 = color_Selected;
      color_1 = color_Unselected;
      color_3 = color_Unselected;
      color_4 = color_Unselected;
      color_5 = color_Unselected;
      color_6 = color_Unselected;
      color_7 = color_Unselected;
      color_8 = color_Unselected;
      color_9 = color_Unselected;
      color_10 = color_Unselected;
      Provider.of<NewDataByShipper>(context, listen: false)
          .updateNoOfTrucks(newValue: '2');
    } else if (cardNumber == 3 && color_3 == color_Unselected) {
      color_3 = color_Selected;
      color_2 = color_Unselected;
      color_1 = color_Unselected;
      color_4 = color_Unselected;
      color_5 = color_Unselected;
      color_6 = color_Unselected;
      color_7 = color_Unselected;
      color_8 = color_Unselected;
      color_9 = color_Unselected;
      color_10 = color_Unselected;
      Provider.of<NewDataByShipper>(context, listen: false)
          .updateNoOfTrucks(newValue: '3');
    } else if (cardNumber == 4 && color_4 == color_Unselected) {
      color_4 = color_Selected;
      color_2 = color_Unselected;
      color_3 = color_Unselected;
      color_1 = color_Unselected;
      color_5 = color_Unselected;
      color_6 = color_Unselected;
      color_7 = color_Unselected;
      color_8 = color_Unselected;
      color_9 = color_Unselected;
      color_10 = color_Unselected;
      Provider.of<NewDataByShipper>(context, listen: false)
          .updateNoOfTrucks(newValue: '4');
    } else if (cardNumber == 5 && color_5 == color_Unselected) {
      color_5 = color_Selected;
      color_2 = color_Unselected;
      color_3 = color_Unselected;
      color_4 = color_Unselected;
      color_1 = color_Unselected;
      color_6 = color_Unselected;
      color_7 = color_Unselected;
      color_8 = color_Unselected;
      color_9 = color_Unselected;
      color_10 = color_Unselected;
      Provider.of<NewDataByShipper>(context, listen: false)
          .updateNoOfTrucks(newValue: '5');
    } else if (cardNumber == 6 && color_6 == color_Unselected) {
      color_6 = color_Selected;
      color_2 = color_Unselected;
      color_3 = color_Unselected;
      color_4 = color_Unselected;
      color_5 = color_Unselected;
      color_1 = color_Unselected;
      color_7 = color_Unselected;
      color_8 = color_Unselected;
      color_9 = color_Unselected;
      color_10 = color_Unselected;
      Provider.of<NewDataByShipper>(context, listen: false)
          .updateNoOfTrucks(newValue: '6');
    } else if (cardNumber == 7 && color_7 == color_Unselected) {
      color_7 = color_Selected;
      color_2 = color_Unselected;
      color_3 = color_Unselected;
      color_4 = color_Unselected;
      color_5 = color_Unselected;
      color_6 = color_Unselected;
      color_1 = color_Unselected;
      color_8 = color_Unselected;
      color_9 = color_Unselected;
      color_10 = color_Unselected;
      Provider.of<NewDataByShipper>(context, listen: false)
          .updateNoOfTrucks(newValue: '7');
    } else if (cardNumber == 8 && color_8 == color_Unselected) {
      color_8 = color_Selected;
      color_2 = color_Unselected;
      color_3 = color_Unselected;
      color_4 = color_Unselected;
      color_5 = color_Unselected;
      color_6 = color_Unselected;
      color_7 = color_Unselected;
      color_1 = color_Unselected;
      color_9 = color_Unselected;
      color_10 = color_Unselected;
      Provider.of<NewDataByShipper>(context, listen: false)
          .updateNoOfTrucks(newValue: '8');
    } else if (cardNumber == 9 && color_9 == color_Unselected) {
      color_9 = color_Selected;
      color_2 = color_Unselected;
      color_3 = color_Unselected;
      color_4 = color_Unselected;
      color_5 = color_Unselected;
      color_6 = color_Unselected;
      color_7 = color_Unselected;
      color_8 = color_Unselected;
      color_1 = color_Unselected;
      color_10 = color_Unselected;
      Provider.of<NewDataByShipper>(context, listen: false)
          .updateNoOfTrucks(newValue: '9');
    } else if (cardNumber == 10 && color_10 == color_Unselected) {
      color_10 = color_Selected;
      color_2 = color_Unselected;
      color_3 = color_Unselected;
      color_4 = color_Unselected;
      color_5 = color_Unselected;
      color_6 = color_Unselected;
      color_7 = color_Unselected;
      color_8 = color_Unselected;
      color_9 = color_Unselected;
      color_1 = color_Unselected;
      Provider.of<NewDataByShipper>(context, listen: false)
          .updateNoOfTrucks(newValue: '10');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.only(left: 3, right: 3, top: 3, bottom: 3),
      insetPadding: EdgeInsets.only(
        left: 0,
        right: 0,
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            Container(
              height: 50,
              child: Center(
                child: Text('Select No Of Trucks'),
              ),
              color: Color(0xFFF3F2F1),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildNoOfTrucksCard(
                      context: context,
                      CardName: '1',
                      CardNumber: 1,
                      CardColor: color_1),
                  buildNoOfTrucksCard(
                      context: context,
                      CardName: '2',
                      CardNumber: 2,
                      CardColor: color_2),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildNoOfTrucksCard(
                      context: context,
                      CardName: '3',
                      CardNumber: 3,
                      CardColor: color_3),
                  buildNoOfTrucksCard(
                      context: context,
                      CardName: '4',
                      CardNumber: 4,
                      CardColor: color_4),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildNoOfTrucksCard(
                      context: context,
                      CardName: '5',
                      CardNumber: 5,
                      CardColor: color_5),
                  buildNoOfTrucksCard(
                      context: context,
                      CardName: '6',
                      CardNumber: 6,
                      CardColor: color_6),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildNoOfTrucksCard(
                      context: context,
                      CardName: '7',
                      CardNumber: 7,
                      CardColor: color_7),
                  buildNoOfTrucksCard(
                      context: context,
                      CardName: '8',
                      CardNumber: 8,
                      CardColor: color_8),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildNoOfTrucksCard(
                      context: context,
                      CardName: '9',
                      CardNumber: 9,
                      CardColor: color_9),
                  buildNoOfTrucksCard(
                      context: context,
                      CardName: '10',
                      CardNumber: 10,
                      CardColor: color_10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector buildNoOfTrucksCard(
      {BuildContext context,
      String CardName,
      int CardNumber,
      Color CardColor}) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        setState(() {
          invert_all_colour(CardNumber);
        });
      },
      child: Container(
        color: CardColor,
        height: 70,
        width: 70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '$CardName',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
