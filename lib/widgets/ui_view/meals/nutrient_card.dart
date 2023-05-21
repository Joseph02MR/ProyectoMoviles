import 'package:final_moviles/fitness_app_theme.dart';
import 'package:final_moviles/utils/hexcolor.dart';
import 'package:flutter/material.dart';

class NutrientCard extends StatelessWidget {
  const NutrientCard(
      {super.key,
      required this.name,
      required this.color,
      required this.quantity,
      required this.measure,
      required this.animation});
  final String name;
  final String color;
  final double quantity;
  final String measure;
  final Animation animation;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          height: 48,
          width: 2,
          decoration: BoxDecoration(
            color: HexColor(color).withOpacity(0.5),
            borderRadius: const BorderRadius.all(Radius.circular(4.0)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 4, bottom: 2),
                child: Text(
                  name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: FitnessAppTheme.fontName,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    letterSpacing: -0.1,
                    color: FitnessAppTheme.grey.withOpacity(0.5),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  SizedBox(
                    width: 28,
                    height: 28,
                    child: Image.asset("assets/fitness_app/eaten.png"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4, bottom: 3),
                    child: Text(
                      quantity.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: FitnessAppTheme.fontName,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: FitnessAppTheme.darkerText,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4, bottom: 3),
                    child: Text(
                      measure,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: FitnessAppTheme.fontName,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        letterSpacing: -0.2,
                        color: FitnessAppTheme.grey.withOpacity(0.5),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
