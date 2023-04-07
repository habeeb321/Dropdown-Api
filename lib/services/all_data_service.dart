import 'dart:developer';
import 'package:barcode_scanner/model/home_model.dart';
import 'package:dio/dio.dart';

class AllDataService {
  Future<List<HomeModel>?> fetchAllApi() async {
    try {
      Dio dio = Dio();
      Response response = await dio.get("https://fakestoreapi.com/products");
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((e) => HomeModel.fromJson(e))
            .toList();
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
