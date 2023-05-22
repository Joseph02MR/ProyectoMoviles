import 'package:get/get.dart';

class RegisterController extends GetxController {
  var selected = "".obs;
  var ispasswordev = true.obs;

  void setSelected(value) {
    selected.value = value;
  }

  void setViewablePass() {
    ispasswordev.value = ispasswordev.isTrue ? false : true;
  }
}
