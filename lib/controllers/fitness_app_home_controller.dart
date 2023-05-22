import 'package:final_moviles/fitness_app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class TabBodyController extends GetxController {
  Rx<Widget> tab = Container().obs;

void setValue(value) {
  tab.value = value;
}
}