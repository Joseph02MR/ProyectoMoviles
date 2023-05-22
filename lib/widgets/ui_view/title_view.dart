import 'package:final_moviles/firebase/dao/diary_data_dao.dart';
import 'package:final_moviles/models/diary_data.dart';
import 'package:final_moviles/utils/userdata.dart';
import 'package:flutter/material.dart';

import '../../fitness_app_theme.dart';

class TitleView extends StatelessWidget {
  final String titleTxt;
  final String subTxt;
  final AnimationController? animationController;
  final Animation<double>? animation;

  const TitleView(
      {Key? key,
      this.titleTxt = "",
      this.subTxt = "",
      this.animationController,
      this.animation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 30 * (1.0 - animation!.value), 0.0),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 24, right: 24),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        titleTxt,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontFamily: FitnessAppTheme.fontName,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          letterSpacing: 0.5,
                          color: FitnessAppTheme.lightText,
                        ),
                      ),
                    ),
                    subTxt != ""
                        ? InkWell(
                            highlightColor: Colors.transparent,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4.0)),
                            onTap: () {
                              UserData.dao.saveData(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    subTxt,
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                      fontFamily: FitnessAppTheme.fontName,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16,
                                      letterSpacing: 0.5,
                                      color: FitnessAppTheme.nearlyDarkBlue,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 38,
                                    width: 26,
                                    child: Icon(
                                      Icons.arrow_forward,
                                      color: FitnessAppTheme.darkText,
                                      size: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Container()
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
