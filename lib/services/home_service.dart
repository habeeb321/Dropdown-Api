import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class HomeService {
  Future<List<dynamic>?> fetchApi() async {
    try {
      var baseUrl = "https://fakestoreapi.com/products";
      http.Response response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        return jsonData;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
