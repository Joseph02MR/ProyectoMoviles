import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_moviles/controllers/profile_screen_controller.dart';
import 'package:final_moviles/fitness_app_theme.dart';
import 'package:final_moviles/utils/hexcolor.dart';
import 'package:final_moviles/widgets/ui_view/wave_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:supercharged/supercharged.dart';

class WaterView extends StatefulWidget {
  const WaterView(
      {Key? key, this.mainScreenAnimationController, this.mainScreenAnimation})
      : super(key: key);

  final AnimationController? mainScreenAnimationController;
  final Animation<double>? mainScreenAnimation;

  @override
  _WaterViewState createState() => _WaterViewState();
}

class _WaterViewState extends State<WaterView> with TickerProviderStateMixin {
  ProfileScreenController dataController = Get.put(ProfileScreenController());
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  var watervalue = 0;
  var aux = 0;

  double caclulus() {
    double? initialGoal = dataController.wgoal.value.toDouble();

    double percentage = dataController.wardaily.value != ''
        ? (((aux.toDouble()) / initialGoal!) * 100)
        : (((watervalue / initialGoal!) * 100));
    print(aux);
    print(percentage);
    return percentage;
  }

  Future<void> saveWater() async {
    final userCollection = FirebaseFirestore.instance.collection('users');

    userCollection.doc(dataController.id).update({
      'waterdaily': dataController.wardaily.value != ''
          ? aux.toString()
          : watervalue.toString()
    });
  }

  void myAlert() {
    aux = dataController.wardaily.value.toInt()!;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              title: const Text('Agua consumida en el día'),
              content: Padding(
                padding: const EdgeInsets.only(
                    top: 8, left: 16, right: 16, bottom: 8),
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 180,
                      child: Expanded(
                        child: Row(
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                        padding: const EdgeInsets.only(
                                            left: 4, bottom: 3),
                                        child: Obx(
                                          () => dataController.wardaily.value !=
                                                  ''
                                              ? Text(
                                                  aux.toString(),
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                    fontFamily: FitnessAppTheme
                                                        .fontName,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 32,
                                                    color: FitnessAppTheme
                                                        .nearlyDarkBlue,
                                                  ),
                                                )
                                              : Text(
                                                  watervalue.toString(),
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                    fontFamily: FitnessAppTheme
                                                        .fontName,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 32,
                                                    color: FitnessAppTheme
                                                        .nearlyDarkBlue,
                                                  ),
                                                ),
                                        )),
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(left: 8, bottom: 8),
                                      child: Text(
                                        'ml',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: FitnessAppTheme.fontName,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                          letterSpacing: -0.2,
                                          color: FitnessAppTheme.nearlyDarkBlue,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        left: 4, top: 2, bottom: 14),
                                    child: Obx(
                                      () => Text(
                                        'of ${dataController.wgoal.value} goal',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontFamily: FitnessAppTheme.fontName,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          letterSpacing: 0.0,
                                          color: FitnessAppTheme.darkText,
                                        ),
                                      ),
                                    )),
                                SizedBox(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        decoration: BoxDecoration(
                                          color: FitnessAppTheme.nearlyWhite,
                                          shape: BoxShape.circle,
                                          boxShadow: <BoxShadow>[
                                            BoxShadow(
                                                color: FitnessAppTheme
                                                    .nearlyDarkBlue
                                                    .withOpacity(0.4),
                                                offset: const Offset(4.0, 4.0),
                                                blurRadius: 8.0),
                                          ],
                                        ),
                                        child: Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: InkWell(
                                              onTap: () {
                                                dataController.wardaily.value !=
                                                        ''
                                                    ? aux = aux + 100
                                                    : watervalue =
                                                        watervalue + 100;

                                                setState(() {});
                                              },
                                              child: const Icon(
                                                Icons.add,
                                                color: FitnessAppTheme
                                                    .nearlyDarkBlue,
                                                size: 20,
                                              ),
                                            )),
                                      ),
                                      const SizedBox(
                                        width: 28,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: FitnessAppTheme.nearlyWhite,
                                          shape: BoxShape.circle,
                                          boxShadow: <BoxShadow>[
                                            BoxShadow(
                                                color: FitnessAppTheme
                                                    .nearlyDarkBlue
                                                    .withOpacity(0.4),
                                                offset: const Offset(4.0, 4.0),
                                                blurRadius: 8.0),
                                          ],
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: InkWell(
                                            onTap: () {
                                              dataController.wardaily.value !=
                                                      ''
                                                  ? aux = aux - 100
                                                  : watervalue =
                                                      watervalue - 100;

                                              setState(() {});
                                            },
                                            child: const Icon(
                                              Icons.remove,
                                              color: FitnessAppTheme
                                                  .nearlyDarkBlue,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    child: Flexible(
                                        child: ElevatedButton(
                                            onPressed: () {
                                              saveWater();
                                              AwesomeDialog(
                                                context: context,
                                                dialogType: DialogType.success,
                                                animType: AnimType.rightSlide,
                                                title: 'Hidratacion',
                                                desc:
                                                    'Tu progreso fue registrado',
                                                btnOkOnPress: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ).show();
                                            },
                                            child: const Text("Guardar"))),
                                  ),
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 26, right: 8, top: 8),
                                  child: Container(
                                    width: 60,
                                    height: 160,
                                    decoration: BoxDecoration(
                                      color: HexColor('#E8EDFE'),
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(80.0),
                                          bottomLeft: Radius.circular(80.0),
                                          bottomRight: Radius.circular(80.0),
                                          topRight: Radius.circular(80.0)),
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                            color: FitnessAppTheme.grey
                                                .withOpacity(0.4),
                                            offset: const Offset(2, 2),
                                            blurRadius: 4),
                                      ],
                                    ),
                                    child: WaveView(
                                      percentageValue: caclulus(),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    Future<void> getUserData() async {
      final QuerySnapshot<Map<String, dynamic>> users = await firestore
          .collection('users')
          .where('email', isEqualTo: FirebaseAuth.instance.currentUser?.email)
          .get();

      for (final QueryDocumentSnapshot<Map<String, dynamic>> user
          in users.docs) {
        final Map<String, dynamic> data = user.data();
        dataController.wgoal.value = data['watergoal'].toString();
        dataController.id = user.id;
        dataController.wardaily.value = data['waterdaily'].toString();
        print(dataController.wgoal.value);
        print(dataController.wardaily.value);
      }
    }

    getUserData();

    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return AnimatedBuilder(
        animation: widget.mainScreenAnimationController!,
        builder: (BuildContext context, Widget? child) {
          return FadeTransition(
            opacity: widget.mainScreenAnimation!,
            child: Transform(
              transform: Matrix4.translationValues(
                  0.0, 30 * (1.0 - widget.mainScreenAnimation!.value), 0.0),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 24, right: 24, top: 16, bottom: 18),
                child: Container(
                  decoration: BoxDecoration(
                    color: FitnessAppTheme.white,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8.0),
                        bottomRight: Radius.circular(8.0),
                        topRight: Radius.circular(68.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: FitnessAppTheme.grey.withOpacity(0.2),
                          offset: const Offset(1.1, 1.1),
                          blurRadius: 10.0),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 16, left: 16, right: 16, bottom: 16),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 4, bottom: 3),
                                        child: Obx(() => dataController
                                                    .wardaily.value !=
                                                ''
                                            ? Text(
                                                dataController.wardaily.value,
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  fontFamily:
                                                      FitnessAppTheme.fontName,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 32,
                                                  color: FitnessAppTheme
                                                      .nearlyDarkBlue,
                                                ),
                                              )
                                            : Text(
                                                watervalue.toString(),
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  fontFamily:
                                                      FitnessAppTheme.fontName,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 32,
                                                  color: FitnessAppTheme
                                                      .nearlyDarkBlue,
                                                ),
                                              )),
                                      ),
                                      const Padding(
                                        padding:
                                            EdgeInsets.only(left: 8, bottom: 8),
                                        child: Text(
                                          'ml',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily:
                                                FitnessAppTheme.fontName,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18,
                                            letterSpacing: -0.2,
                                            color:
                                                FitnessAppTheme.nearlyDarkBlue,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          left: 4, top: 2, bottom: 14),
                                      child: Obx(
                                        () => Text(
                                          'of daily goal ${dataController.wgoal.value} ml',
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontFamily:
                                                FitnessAppTheme.fontName,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            letterSpacing: 0.0,
                                            color: FitnessAppTheme.darkText,
                                          ),
                                        ),
                                      )),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 4, right: 4, top: 8, bottom: 16),
                                child: Container(
                                  height: 2,
                                  decoration: const BoxDecoration(
                                    color: FitnessAppTheme.background,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4.0)),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 16),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 4),
                                          child: Icon(
                                            Icons.access_time,
                                            color: FitnessAppTheme.grey
                                                .withOpacity(0.5),
                                            size: 16,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 4.0),
                                          child: Text(
                                            'Last drink 8:26 AM',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily:
                                                  FitnessAppTheme.fontName,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              letterSpacing: 0.0,
                                              color: FitnessAppTheme.grey
                                                  .withOpacity(0.5),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          SizedBox(
                                            width: 24,
                                            height: 24,
                                            child: Image.asset(
                                                'assets/fitness_app/bell.png'),
                                          ),
                                          Flexible(
                                            child: Text(
                                              'Your bottle is empty, refill it!.',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontFamily:
                                                    FitnessAppTheme.fontName,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                                letterSpacing: 0.0,
                                                color: HexColor('#F65283'),
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                              child: ElevatedButton(
                                                  onPressed: () {
                                                    myAlert();
                                                  },
                                                  child: const Text("Fill it")))
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
