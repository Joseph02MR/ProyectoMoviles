import 'package:final_moviles/models/diary_data.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

class ProfileScreenController extends GetxController {
  @override
  void onInit() {
    ever(wardaily, (callback) {
      DiaryData.setWaterData(callback);
      logger.i('water value changed');
    });
    super.onInit();
  }

  var logger = Logger(
    printer: PrettyPrinter(),
  );

  var email = ''.obs;
  var name = ''.obs;
  var photo = ''.obs;
  var localPhoto = XFile('/').obs;
  var id = "";
  var age = ''.obs;
  var height = ''.obs;
  var weight = ''.obs;
  var wgoal = ''.obs;
  var sgoal = ''.obs;
  var cgoal = ''.obs;
  var wardaily = ''.obs;

  void setData(em, na, ph, ag, he, we, wg, sg, cg, wd) {
    email.value = em;
    name.value = na;
    photo.value = ph;
    age.value = ag;
    height.value = he;
    weight.value = we;
    wgoal.value = wg;
    sgoal.value = sg;
    cgoal.value = cg;
    wardaily.value = wd;
  }

  void setImage(photo) {
    localPhoto.value = photo;
  }

  void setWaterValue(value) {
    wardaily.value = value;
  }
}
