import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:final_moviles/models/food.dart';
import 'package:logger/logger.dart';

class FoodsApi {
  var logger = Logger(
    printer: PrettyPrinter(),
  );

  final dio = Dio();

  Uri link = Uri.parse(
      'https://api.edamam.com/api/food-database/v2/parser?app_id=ad7f2a54&app_key=81c06ec024dda12af7cc4560af69840f&ingr=');
  Future<Food?>? getFoodData(String food) async {
    String foodParsed = food.replaceAll(" ", "%20");
    var result = await dio.get(link.origin + foodParsed);
    var listJson = jsonDecode(result.data)['parsed']['food'];
    if (result.statusCode == 200) {
      return Food.fromJson(listJson);
    }
    return null;
  }
}
