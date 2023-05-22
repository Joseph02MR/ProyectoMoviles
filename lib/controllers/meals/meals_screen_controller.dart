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
    ever(insertedFoodList, (callback) {
      DiaryData.mealsData[mealName] = callback;
    });
    setInMeaslMaster();
    super.onInit();
  }

  void setInMeaslMaster() {}

  var insertedFood = "".obs;

  var mealKcal = 0.0.obs;
  var mealCarbs = 0.0.obs;
  var mealProts = 0.0.obs;
  var mealFats = 0.0.obs;

  final String mealName;

  MealsScreenController({this.mealName = ""});

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
    saveDataInDiary();
    saveDataInMealsMaster();
    logger.i(DiaryData.mealsData[mealName].toString());
  }

  void saveDataInDiary() {
    DiaryData.mealsData[mealName] = Map.from({
      "name": mealName,
      "nutrient_data": nutrientDataToMap(),
      "food_list": List.from(insertedFoodList.map((element) => element.toMap()))
    });
  }

  void saveDataInMealsMaster() {
    MealsMasterController.mealsList[mealName] = Map.from({
      "name": mealName,
      "nutrient_data": nutrientDataToMap(),
      "food_list": List.from(insertedFoodList.map((element) => element.toMap()))
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
