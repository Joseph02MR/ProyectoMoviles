import 'package:get/get.dart';

class LoginController extends GetxController {
  var selected = "email".obs;
  var ispasswordev = true.obs;

  void setSelected(value) {
    selected.value = value;
  }

  void setViewablePass() {
    ispasswordev.value = ispasswordev.isTrue ? false : true;
  }
}
