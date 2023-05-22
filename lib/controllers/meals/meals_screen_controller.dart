import 'package:final_moviles/controllers/meals/food_list_controller.dart';
import 'package:final_moviles/controllers/meals/meals_master_controller.dart';
import 'package:final_moviles/models/diary_data.dart';
import 'package:final_moviles/models/food.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class MealsScreenController extends GetxController {
  var logger = Logger(
    printer: PrettyPrinter(),
  );

  @override
  void onInit() {
    List<Food>.from(MealsMasterController.mealsList[mealName]['food_list']).obs;
    ever(insertedFoodList, (callback) {
      DiaryData.mealsData[mealName] = callback;
    });
    super.onInit();
  }

  var insertedFood = "".obs;

  var mealKcal = 0.0.obs;
  var mealCarbs = 0.0.obs;
  var mealProts = 0.0.obs;
  var mealFats = 0.0.obs;

  final String mealName;

  MealsScreenController({this.mealName = ""});

  var insertedFoodList = List<Food>.from({}).obs;

  void setInsertedFood(value) {
    insertedFoodList.add(value);
    updateNutrimentalData();
    update();
  }

  void removeFoodFromList(index) {
    List<Food>.from(MealsMasterController.mealsList[mealName]['food_list'])
        .removeWhere((element) => false);
    updateNutrimentalData();
    logger.i(MealsMasterController.mealsList[mealName]['food_list'].toString());
  }

  void resetMealData() {
    mealKcal.value = 0.0;
    mealCarbs.value = 0.0;
    mealProts.value = 0.0;
    mealFats.value = 0.0;
  }

  void updateNutrimentalData() {
    resetMealData();
    for (Food element in insertedFoodList) {
      mealKcal.value += element.enercKcal * element.portion;
      mealCarbs.value += element.chocdf * element.portion;
      mealProts.value += element.procnt * element.portion;
      mealFats.value += element.fat * element.portion;
    }
    saveDataInMealsMaster();
    DiaryData.setDiaryData((MealsMasterController()));
  }

  void saveDataInDiary() {
    DiaryData.mealsData[mealName] = Map.from({
      "name": mealName,
      "nutrient_data": nutrientDataToMap(),
      "food_list":
          List<Food>.from(insertedFoodList.map((element) => element.toMap()))
    });
  }

  void saveDataInMealsMaster() {
    MealsMasterController.mealsList[mealName] = Map.from({
      "name": mealName,
      "nutrient_data": nutrientDataToMap(),
      "food_list": List<Food>.from(insertedFoodList.map((element) => element))
    });
    MealsMasterController.updateDayNutrimentalData();
  }

  Map<String, double> nutrientDataToMap() {
    return Map.from({
      "kcal": mealKcal.value,
      "carbs": mealCarbs.value,
      "prots": mealProts.value,
      "fats": mealFats.value
    });
  }

  double getMealKcal() {
    return mealKcal.value;
  }

  double getMealCarbs() {
    return mealCarbs.value;
  }

  double getMealProts() {
    return mealProts.value;
  }

  double getMealFats() {
    return mealFats.value;
  }
}
