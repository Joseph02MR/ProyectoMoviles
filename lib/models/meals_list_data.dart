import 'package:final_moviles/controllers/meals/meals_screen_controller.dart';

class MealsListData {
  MealsListData({
    this.imagePath = '',
    this.titleTxt = '',
    this.startColor = '',
    this.endColor = '',
    required this.mealDataController,
  });

  String imagePath;
  String titleTxt;
  String startColor;
  String endColor;
  final MealsScreenController mealDataController;

  static List<MealsListData> tabIconsList = <MealsListData>[
    MealsListData(
        imagePath: 'assets/fitness_app/breakfast.png',
        titleTxt: 'Breakfast',
        startColor: '#FA7D82',
        endColor: '#FFB295',
        mealDataController: MealsScreenController(mealName: 'Breakfast')),
    MealsListData(
        imagePath: 'assets/fitness_app/lunch.png',
        titleTxt: 'Lunch',
        startColor: '#738AE6',
        endColor: '#5C5EDD',
        mealDataController: MealsScreenController(mealName: 'Lunch')),
    MealsListData(
        imagePath: 'assets/fitness_app/snack.png',
        titleTxt: 'Snack',
        startColor: '#FE95B6',
        endColor: '#FF5287',
        mealDataController: MealsScreenController(mealName: 'Snack')),
    MealsListData(
        imagePath: 'assets/fitness_app/dinner.png',
        titleTxt: 'Dinner',
        startColor: '#6F72CA',
        endColor: '#1E1466',
        mealDataController: MealsScreenController(mealName: 'Dinner')),
  ];
}
