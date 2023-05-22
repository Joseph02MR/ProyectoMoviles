import 'package:get/get.dart';

class OnboardingController extends GetxController {
  var page = 0.obs;

void setPageValue(value) {
    page.value = value;
  }
}
