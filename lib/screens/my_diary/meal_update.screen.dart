import 'package:final_moviles/controllers/meals/meals_screen_controller.dart';
import 'package:final_moviles/models/meals_list_data.dart';
import 'package:final_moviles/widgets/ui_view/meals/diet_details_view.dart';
import 'package:final_moviles/widgets/ui_view/meals/meal_detail_view.dart';
import 'package:final_moviles/widgets/ui_view/mediterranean_diet_view.dart';
import 'package:flutter/material.dart';

class MealUpdateScreen extends StatelessWidget {
  const MealUpdateScreen(
      {super.key,
      this.mealsListData,
      this.animationController,
      this.animation,
      this.mealsCon});
  final MealsListData? mealsListData;
  final AnimationController? animationController;
  final Animation<double>? animation;
  final MealsScreenController? mealsCon;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MealsDetailView(
          mealsListData: mealsListData,
          animationController: animationController,
          animation: animation,
          mealsCon: mealsCon,
        ),
      ],
    );
  }
}
