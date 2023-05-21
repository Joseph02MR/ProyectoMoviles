import 'package:final_moviles/api/foods_api.dart';
import 'package:final_moviles/models/food.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class AddMealController extends GetxController {
  FoodsApi foodApiObj = FoodsApi();
  Food? foodObj;
  var insertedText = "".obs;
  var portion = 0.obs;

  var foodKcal = 0.0.obs;
  var foodCarbs = 0.0.obs;
  var foodProts = 0.0.obs;
  var foodFats = 0.0.obs;
  var foodName = "";

  var logger = Logger(
    printer: PrettyPrinter(),
  );

  void setInsertedText(value) {
    insertedText.value = value;
  }

  void setFoodPortion(value) {
    try {
      portion.value = int.parse(value);
    } catch (e) {
      logger.w(e);
    }
  }

  void setFoodData(Food food) {
    foodKcal.value = food.enercKcal;
    foodCarbs.value = food.chocdf;
    foodProts.value = food.procnt;
    foodFats.value = food.fat;
    foodName = food.label;
  }

  Future<bool> getFoodData() async {
    foodObj = await foodApiObj.getFoodData(insertedText.value);
    if (foodObj != null) {
      setFoodData(foodObj!);
      return true;
    } else {
      return false;
    }
  }
}
