import 'package:final_moviles/controllers/meals/meals_master_controller.dart';
import 'package:final_moviles/models/food.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class FoodListController extends GetxController {
  static var logger = Logger(
    printer: PrettyPrinter(),
  );
  String name = "";
  var foodList = List<Food>.from({}).obs;

  static FoodListController get to => Get.find();
  FoodListController(value, list) {
    name = value;
    foodList.value = list;
  }

  void setInsertedFood(value) {
    foodList.add(value);
    update();
  }

  void removeFoodFromList(index) {
    foodList.removeAt(index);
    update();
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    //MealsMasterController.mealsList['name']['food_list'] = foodList;
    super.onClose();
  }
}
