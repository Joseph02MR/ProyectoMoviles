import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:final_moviles/models/food.dart';
import 'package:logger/logger.dart';

class FoodsApi {
  var logger = Logger(
    printer: PrettyPrinter(),
  );

  FoodsApi() {
    dio.interceptors.add(
        DioCacheManager(CacheConfig(baseUrl: "https://api.edamam.com"))
            .interceptor);
  }

  final dio = Dio();

  Uri link = Uri.parse(
      'https://api.edamam.com/api/food-database/v2/parser?app_id=ad7f2a54&app_key=81c06ec024dda12af7cc4560af69840f&ingr=');
  Future<Food?>? getFoodData(String food) async {
    String foodParsed = food.replaceAll(" ", "%20");
    try {
      var result = await dio.get(link.toString() + foodParsed,
          options: buildCacheOptions(const Duration(days: 7)));
      var listJson = result.data['parsed'][0]['food'];
      if (result.statusCode == 200) {
        return Food.fromJson(listJson);
      }
    } catch (e) {
      logger.w(e);
    }
    return null;
  }
}
