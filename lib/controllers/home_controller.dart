import 'package:get/get.dart';

class HomeController extends GetxController {
  final deux = RxInt(0);
  setDeux(value) {
    deux.value = value;
    update();
  }
}
