import 'package:final_moviles/fitness_app_theme.dart';
import 'package:final_moviles/models/meals_list_data.dart';
import 'package:final_moviles/utils/hexcolor.dart';
import 'package:final_moviles/widgets/ui_view/meals/diet_details_view.dart';
import 'package:flutter/material.dart';

class MealsDetailView extends StatelessWidget {
  const MealsDetailView(
      {Key? key, this.mealsListData, this.animationController, this.animation})
      : super(key: key);

  final MealsListData? mealsListData;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                100 * (1.0 - animation!.value), 0.0, 0.0),
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 32, left: 8, right: 8, bottom: 16),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: HexColor(mealsListData!.endColor)
                                  .withOpacity(0.6),
                              offset: const Offset(1.1, 4.0),
                              blurRadius: 8.0),
                        ],
                        gradient: LinearGradient(
                          colors: <HexColor>[
                            HexColor(mealsListData!.startColor),
                            HexColor(mealsListData!.endColor),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(8.0),
                          bottomLeft: Radius.circular(8.0),
                          topLeft: Radius.circular(8.0),
                          topRight: Radius.circular(54.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 54, left: 16, right: 16, bottom: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            DietDetailsView(
                              animation: animation,
                              animationController: animationController,
                            ),
                            Text(
                              mealsListData!.titleTxt,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontFamily: FitnessAppTheme.fontName,
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                letterSpacing: 0.2,
                                color: FitnessAppTheme.white,
                              ),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            SizedBox.square(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 4, bottom: 4),
                                child: SizedBox(
                                  height: 250,
                                  child: ListView(
                                    shrinkWrap: true,
                                    children: <Widget>[
                                      Text(
                                        mealsListData!.meals!.join('\n'),
                                        style: const TextStyle(
                                          fontFamily: FitnessAppTheme.fontName,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          letterSpacing: 0.2,
                                          color: FitnessAppTheme.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    onPressed: () {},
                                    child: const Text("Agregar alimentos"))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 40,
                    left: 15,
                    child: Container(
                      width: 84,
                      height: 84,
                      decoration: BoxDecoration(
                        color: FitnessAppTheme.nearlyWhite.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 40,
                    left: 23,
                    child: SizedBox(
                      width: 80,
                      height: 80,
                      child: Image.asset(mealsListData!.imagePath),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
