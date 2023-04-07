import 'package:barcode_scanner/locator.dart';
import 'package:barcode_scanner/model/home_model.dart';
import 'package:barcode_scanner/services/all_data_service.dart';
import 'package:barcode_scanner/services/home_service.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  List categoryItemlist = [];
  List<HomeModel> products = [];

  var dropdownvalue;

  bool isLoading = false;

  void getApi() async {
    isLoading = true;
    await locator.get<HomeService>().fetchApi().then((value) {
      if (value != null) {
        categoryItemlist = value;
        isLoading = false;
        notifyListeners();
      }
    });
  }

  void valueChanging(newValue) {
    dropdownvalue = newValue;
    notifyListeners();
  }

  void getAllApi() async {
    isLoading = true;
    await locator.get<AllDataService>().fetchAllApi().then((value) {
      if (value != null) {
        products = value;
        isLoading = false;
        notifyListeners();
      }
    });
  }
}
