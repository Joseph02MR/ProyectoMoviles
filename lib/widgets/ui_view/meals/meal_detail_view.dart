import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:final_moviles/controllers/meals/add_meal_controller.dart';
import 'package:final_moviles/controllers/meals/food_list_controller.dart';
import 'package:final_moviles/controllers/meals/meals_master_controller.dart';
import 'package:final_moviles/controllers/meals/meals_screen_controller.dart';
import 'package:final_moviles/fitness_app_theme.dart';
import 'package:final_moviles/models/food.dart';
import 'package:final_moviles/models/meals_list_data.dart';
import 'package:final_moviles/models/nutrient_card_data.dart';
import 'package:final_moviles/utils/hexcolor.dart';
import 'package:final_moviles/widgets/ui_view/meals/diet_details_view.dart';
import 'package:final_moviles/widgets/ui_view/meals/food_tile.dart';
import 'package:final_moviles/widgets/ui_view/meals/nutrient_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class MealsDetailView extends StatelessWidget {
  MealsDetailView(
      {Key? key,
      this.mealsListData,
      this.animationController,
      this.animation,
      this.mealsCon})
      : super(key: key);

  final MealsListData? mealsListData;
  final AnimationController? animationController;
  final Animation<double>? animation;
  final MealsScreenController? mealsCon;

  final AddMealController addmealCon = AddMealController();

  final TextEditingController _tfFoodController = TextEditingController();
  final TextEditingController _ttPortionController = TextEditingController();
  var logger = Logger(
    printer: PrettyPrinter(),
  );

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Ingresa el alimento a registrar'),
            content: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 100,
              child: Column(
                children: [
                  TextField(
                    onChanged: (value) {
                      addmealCon.setInsertedText(value);
                    },
                    controller: _tfFoodController,
                    decoration: const InputDecoration(
                        hintText: "Agrega un alimento..."),
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      addmealCon.setFoodPortion(value);
                    },
                    controller: _ttPortionController,
                    decoration:
                        const InputDecoration(hintText: "No. porciones"),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              MaterialButton(
                color: Colors.red,
                textColor: Colors.white,
                child: const Text('CANCEL'),
                onPressed: () {
                  addmealCon.setInsertedText("");
                  addmealCon.setFoodPortion("0");
                  Get.back();
                },
              ),
              MaterialButton(
                color: Colors.green,
                textColor: Colors.white,
                child: const Text('OK'),
                onPressed: () async {
                  addmealCon.getFoodData().then((value) {
                    addmealCon.foodObj!.setPortion(addmealCon.portion.value);
                    mealsCon!.setInsertedFood(addmealCon.foodObj);
                    FoodListController.to.setInsertedFood(addmealCon.foodObj);
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.success,
                      animType: AnimType.rightSlide,
                      title: 'Ingresar comida',
                      desc: 'Nuevo alimento registrado',
                      btnOkOnPress: () {
                        Get.back();
                      },
                    ).show();
                  }).onError((error, stackTrace) {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.error,
                      animType: AnimType.rightSlide,
                      title: 'Ingresar comida',
                      desc: 'No pudimos agregar el alimento ingresado. :(',
                      btnOkOnPress: () {
                        Get.back();
                      },
                    ).show();
                    logger.w(error);
                    logger.i(stackTrace);
                  });
                },
              ),
            ],
          );
        });
  }

  Future<void> _displayFoodDetailsDialog(BuildContext context, index) async {
    Food aux = FoodListController.to.foodList[index];
    List<NutrientCardData> nutriotionalData = List.from({
      NutrientCardData('Carbs', '#87A0E5', aux.chocdf, 'g'),
      NutrientCardData('Protein', '#F56E98', aux.procnt, 'g'),
      NutrientCardData('Fat', '#F1B440', aux.fat, 'g'),
      NutrientCardData('Energy', '#A1E3A0', aux.enercKcal, 'kcal'),
      NutrientCardData('Portions', '#A1E3A0', aux.portion.toDouble(), ''),
      //{"color":'#87A0E5',"name":},{"color":'#F56E98'},{},{}
    });
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Detalles'),
            content: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 200,
                child: GridView.builder(
                  itemCount: nutriotionalData.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 2,
                      crossAxisCount: 2,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 0),
                  itemBuilder: (BuildContext context, int index) {
                    return NutrientCard(
                      color: nutriotionalData[index].color,
                      animation: animation!,
                      measure: nutriotionalData[index].measure,
                      name: nutriotionalData[index].name,
                      quantity: nutriotionalData[index].quantity,
                    );
                  },
                )),
            actions: <Widget>[
              /*    MaterialButton(
                color: Colors.red,
                textColor: Colors.white,
                child: const Text('Eliminar'),
                onPressed: () {
                  onDelete(context, index);
                },
              ),*/
              MaterialButton(
                color: Colors.green,
                textColor: Colors.white,
                child: const Text('OK'),
                onPressed: () async {
                  Get.back();
                },
              ),
            ],
          );
        });
  }

  void onDelete(context, index) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.rightSlide,
      title: 'Eliminar comida',
      desc: 'Desea eliminar este alimento?',
      btnCancelOnPress: () => Get.off(context),
      btnOkOnPress: () {
        mealsCon?.removeFoodFromList(index);
        Get.back();
      },
    ).show();
  }

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
                              mealsCon: mealsCon!,
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
                                    width: MediaQuery.of(context).size.width,
                                    height: 250,
                                    child: Scaffold(
                                      body: GetBuilder<FoodListController>(
                                        init: FoodListController(
                                            mealsCon!.mealName,
                                            List<Food>.from(
                                                MealsMasterController.mealsList[
                                                        mealsCon!.mealName]
                                                    ['food_list'])),
                                        builder: (_) => ListView.builder(
                                          itemCount: _.foodList.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return InkWell(
                                              onTap: () {
                                                _displayFoodDetailsDialog(
                                                    context, index);
                                                mealsCon!.update();
                                              },
                                              child: FoodTile(
                                                food: _.foodList[index],
                                              ),
                                            );
                                          },
                                          shrinkWrap: true,
                                        ),
                                      ),
                                    )),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      _displayTextInputDialog(context);
                                    },
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
