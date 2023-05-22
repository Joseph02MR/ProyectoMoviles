import 'package:final_moviles/models/food.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class MealsMasterController extends GetxController {
  static var logger = Logger(
    printer: PrettyPrinter(),
  );

  var objDayKcal = 0.0.obs;
  var objDayCarbs = 0.0.obs;
  var objDayProts = 0.0.obs;
  var objDayFats = 0.0.obs;

  static var waterConsumed = 0.obs;
  static var mealsList = Map.from({
    "Breakfast": {
      "name": "Breakfast",
      "nutrient_data": {"kcal": 0, "carbs": 0, "prots": 0, "fats": 0},
      "food_list": List<Food>.from({})
    },
    "Lunch": {
      "name": "Lunch",
      "nutrient_data": {"kcal": 0, "carbs": 0, "prots": 0, "fats": 0},
      "food_list": List<Food>.from({})
    },
    "Snack": {
      "name": "Snack",
      "nutrient_data": {"kcal": 0, "carbs": 0, "prots": 0, "fats": 0},
      "food_list": List<Food>.from({})
    },
    "Dinner": {
      "name": "Dinner",
      "nutrient_data": {"kcal": 0, "carbs": 0, "prots": 0, "fats": 0},
      "food_list": List<Food>.from({})
    }
  }).obs;

  static void deleteEntry(name) {}

  static var dayKcal = 0.0.obs;
  static var dayCarbs = 0.0.obs;
  static var dayProts = 0.0.obs;
  static var dayFats = 0.0.obs;

  static void resetDayData() {
    dayKcal.value = 0.0;
    dayCarbs.value = 0.0;
    dayProts.value = 0.0;
    dayFats.value = 0.0;
  }

  static void setNewWaterValue(value) {
    waterConsumed.value = int.parse(value);
  }

  static void updateDayNutrimentalData() {
    resetDayData();
    for (var element in mealsList.keys) {
      dayKcal.value += mealsList[element]['nutrient_data']['kcal'];
      dayCarbs.value += mealsList[element]['nutrient_data']['carbs'];
      dayProts.value += mealsList[element]['nutrient_data']['prots'];
      dayFats.value += mealsList[element]['nutrient_data']['fats'];
    }
    logger.i(
        'UPDATE NUTRIMENT IN MEALS MASTER ${dayKcal.value} kcals ${dayProts.value} prots ${dayCarbs.value} carbs ${dayFats.value} fats ');
  }

  static Map<String, dynamic> mealsToMap() {
    Map<String, dynamic> aux = Map.from({});

    for (var element in mealsList.keys) {
      List<Map<String, dynamic>> food = List.from({});
      for (Food element in List<Food>.from(mealsList[element]['food_list'])) {
        food.add(element.toMap());
      }
      aux[mealsList[element]['name']] = Map<String, dynamic>.from({
        "name": mealsList[element]['name'],
        "nutrient_data": mealsList[element]['nutrient_data'],
        "food_list": food,
      });
    }
    return aux;
  }

  static Map<String, double> daysNutrientDataToMap() {
    return Map.from({
      "total_kcal": dayKcal.value,
      "total_carb": dayCarbs.value,
      "total_prot": dayProts.value,
      "total_fat": dayFats.value,
    });
  }

  static void FromMap(Map<String, dynamic> map) {
    mealsList.value = map;
    for (var element in map.keys) {
      List<Food> aux = List<Food>.empty(growable: true);
      for (var food in mealsList[element]['food_list']) {
        logger.i(food);
        if (food != null) aux.add(Food.fromMap(food));
      }
      logger.i('aaaaaa $aux ${aux.runtimeType.toString()}');
      mealsList[element]['food_list'] = aux;
    }
  }
}
