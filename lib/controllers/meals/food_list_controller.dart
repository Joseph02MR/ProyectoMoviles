import 'package:final_moviles/models/food.dart';
import 'package:get/get.dart';

class FoodListController extends GetxController {
  static FoodListController get to => Get.find();
  var foodList = List<Food>.from({}).obs;

  FoodListController(list) {
    foodList = list;
  }
}
