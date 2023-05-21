import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:final_moviles/controllers/meals/meals_screen_controller.dart';
import 'package:final_moviles/models/food.dart';
import 'package:final_moviles/utils/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class FoodTile extends StatelessWidget {
  const FoodTile({super.key, required this.food});

  final Food food;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ListTile(
        title: Text(
          '${food.portion}    ${food.label}',
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.apply(color: Colors.black),
        ),
      ),
    );
  }
}
