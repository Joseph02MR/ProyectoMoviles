import 'package:final_moviles/models/food.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class MealsScreenController extends GetxController {
  var logger = Logger(
    printer: PrettyPrinter(),
  );
  var insertedFood = "".obs;

  var mealKcal = 0.0.obs;
  var mealCarbs = 0.0.obs;
  var mealProts = 0.0.obs;
  var mealFats = 0.0.obs;

  var insertedFoodList = List<Food>.empty(growable: true).obs;

  void setInsertedFood(value) {
    insertedFoodList.add(value);
    updateNutrimentalData();
    update();
  }

  void removeFoodFromList(index) {
    insertedFoodList.removeAt(index);
    updateNutrimentalData();
    update();
  }

  void updateNutrimentalData() {
    for (Food element in insertedFoodList) {
      mealKcal.value += element.enercKcal * element.portion;
      mealCarbs.value += element.chocdf * element.portion;
      mealProts.value += element.procnt * element.portion;
      mealFats.value += element.fat * element.portion;
    }
    logger.i(
        '${mealKcal.value} kcals ${mealProts.value} prots ${mealCarbs.value} carbs ${mealFats.value} fats ');
  }
}
