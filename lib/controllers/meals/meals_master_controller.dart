import 'package:get/get.dart';
import 'package:logger/logger.dart';

class MealsMasterController extends GetxController {
  static var logger = Logger(
    printer: PrettyPrinter(),
  );

  @override
  void onInit() {
    // TODO: implement onInit

    ever(dayKcal, (callback) {
      objDayKcal.value = callback;
      update();
    });
    ever(dayCarbs, (callback) {
      objDayCarbs.value = callback;
      update();
    });
    ever(dayProts, (callback) {
      objDayProts.value = callback;
      update();
    });
    ever(dayFats, (callback) {
      objDayFats.value = callback;
      update();
    });
    super.onInit();
  }

  var objDayKcal = 0.0.obs;
  var objDayCarbs = 0.0.obs;
  var objDayProts = 0.0.obs;
  var objDayFats = 0.0.obs;

  static var waterConsumed = 0.obs;
  static var mealsList = Map.from({
    "Breakfast": {
      "name": "Breakfast",
      "nutrient_data": {"kcal": 0, "carbs": 0, "prots": 0, "fats": 0},
      "food_list": {}
    },
    "Lunch": {
      "name": "Lunch",
      "nutrient_data": {"kcal": 0, "carbs": 0, "prots": 0, "fats": 0},
      "food_list": {}
    },
    "Snack": {
      "name": "Snack",
      "nutrient_data": {"kcal": 0, "carbs": 0, "prots": 0, "fats": 0},
      "food_list": {}
    },
    "Dinner": {
      "name": "Dinner",
      "nutrient_data": {"kcal": 0, "carbs": 0, "prots": 0, "fats": 0},
      "food_list": {}
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
    for (var element in mealsList.values) {
      dayKcal.value += element['nutrient_data']['kcal'];
      dayCarbs.value += element['nutrient_data']['carbs'];
      dayProts.value += element['nutrient_data']['prots'];
      dayFats.value += element['nutrient_data']['fats'];
    }
    logger.i(
        'UPDATE NUTRIMENT IN MEALS MASTER ${dayKcal.value} kcals ${dayProts.value} prots ${dayCarbs.value} carbs ${dayFats.value} fats ');
  }

  static Map<String, dynamic> mealsToMap() {
    Map<String, dynamic> aux = Map.from({});
    for (var element in mealsList.values) {
      aux[element['name']] = element;
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
}