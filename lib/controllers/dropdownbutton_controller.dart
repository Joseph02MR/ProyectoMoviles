import 'package:get/get.dart';

class DropdownButtonController extends GetxController {
  final selected = "Kek".obs;

  void setSelected(value) {
    selected.value = value;
  }
}
