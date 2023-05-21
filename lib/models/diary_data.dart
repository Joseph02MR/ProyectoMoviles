import 'package:final_moviles/controllers/meals/meals_master_controller.dart';
import 'package:final_moviles/utils/userdata.dart';

class DiaryData {
  static final DateTime date = DateTime.now();
  static String userId = UserData.uid;
  static String actProfile = UserData.activityProfile;
  static Map<String, double> totalNutrientData = Map.from({});
  static Map<dynamic, dynamic> mealsData = Map.from({});
  static int consumedWater = 0;

  static void setDiaryData(MealsMasterController mealsDayCon) {
    totalNutrientData = MealsMasterController.daysNutrientDataToMap();
    mealsData = MealsMasterController.mealsToMap();
  }

  static void setWaterData(data) {
    consumedWater = int.parse(data);
  }

  static Map<String, dynamic> toMap() {
    return Map.from({
      "date": '${date.year}-${date.month}-${date.day}',
      "user_id": userId,
      "consumed_water": consumedWater,
      "act_profile": actProfile,
      "day_nutrient_data": totalNutrientData,
      "meals_data": mealsData,
    });
  }
}
