import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreenController {
  var email = ''.obs;
  var name = ''.obs;
  var photo = ''.obs;
  var localPhoto = XFile('/').obs;
  var id = "";

  void setData(em, na, ph) {
    email.value = em;
    name.value = na;
    photo.value = ph;
  }

  void setImage(photo) {
    localPhoto.value = photo;
  }
}
