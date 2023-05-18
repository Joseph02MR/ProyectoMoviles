import 'package:get/get.dart';

class DropdownButtonController extends GetxController {
  final selected = "baja".obs;

  void setSelected(value) {
    selected.value = value;
  }
}
