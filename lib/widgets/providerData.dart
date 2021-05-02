import 'package:flutter/cupertino.dart';

// TODO: this code is good but you need to make this into a model folder.

class NewDataByShipper extends ChangeNotifier {
  String loadingPoint;
  String unloadingPoint;
  String productType;
  String truckPreference;
  String noOfTrucks = '1';
  String weight;
  bool isPending = true;
  String comments;
  bool isCommentsEmpty = true;
  List listOfShippers = [];

  void addShipper({String newValue}) {
    listOfShippers.add(newValue);
    print(newValue);
    notifyListeners();
  }

  void updateLoadingPoint({String newValue}) {
    loadingPoint = newValue;
    print(loadingPoint);
    notifyListeners();
  }

  void updateUnloadingPoint({String newValue}) {
    unloadingPoint = newValue;
    print(unloadingPoint);
    notifyListeners();
  }

  void updateProductType({String newValue}) {
    productType = newValue;
    print(productType);
    notifyListeners();
  }

  void updateTruckPreference({String newValue}) {
    truckPreference = newValue;
    print(truckPreference);
    notifyListeners();
  }

  void updateNoOfTrucks({String newValue}) {
    noOfTrucks = newValue;
    print(noOfTrucks);
    notifyListeners();
  }

  void updateWeight({String newValue}) {
    weight = newValue;
    print(weight);
    notifyListeners();
  }

  void updateComments({String newValue}) {
    comments = newValue;
    print(comments);
    notifyListeners();
  }

  void updateIsCommentsEmpty({bool newValue}) {
    isCommentsEmpty = newValue;
    print(isCommentsEmpty);
    notifyListeners();
  }

  void clearAll() {
    loadingPoint = null;
    unloadingPoint = null;
    productType = null;
    truckPreference = null;
    noOfTrucks = '1';
    weight = null;
    isPending = true;
    comments = null;
    isCommentsEmpty = true;
    notifyListeners();
  }
}
