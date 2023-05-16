import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_moviles/controllers/dropdownbutton_controller.dart';
import 'package:final_moviles/controllers/profile_screen_controller.dart';
import 'package:final_moviles/utils/assets_constants.dart';
import 'package:final_moviles/utils/color_constants.dart';
import 'package:final_moviles/utils/text_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:logger/logger.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key, required this.controller});
  final ProfileScreenController controller;

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  var logger = Logger(
    printer: PrettyPrinter(),
  );
  ProfileScreenController? aux;
  final ImagePicker picker = ImagePicker();

  @override
  void initState() {
    super.initState();
  }

  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);
    widget.controller.setImage(img);
  }

  Future<void> saveProfile() async {
    // Create a storage reference from our app
    final storageRef = FirebaseStorage.instance.ref();

// Create a reference to "mountains.jpg"
    final mountainsRef =
        storageRef.child('${widget.controller.id}/profile.png');

    String imageUrl = await mountainsRef.getDownloadURL();

    try {
      if (widget.controller.localPhoto.value.path != '/') {
        await mountainsRef
            .putFile(File(widget.controller.localPhoto.value.path));
      }
    } catch (e) {
      logger.w(e);
    }

    final usermail = FirebaseAuth.instance.currentUser?.email;
    final userCollection = FirebaseFirestore.instance.collection('users');

    final userdoc = userCollection.where('email', isEqualTo: usermail);

    //userCollection.doc(usermail).update({
    userCollection.doc(widget.controller.id).update({
      'name': widget.controller.name.value,
      'photo': widget.controller.localPhoto.value.path != '/'
          ? imageUrl
          : widget.controller.photo,
      // Add any other user information here
    });
  }

  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: const Text('Escoge la imagen a subir'),
            content: SizedBox(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.image),
                        Text('From Gallery'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    //if user click this button. user can upload image from camera
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.camera),
                        Text('From Camera'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    DropdownButtonController drop_con = DropdownButtonController();

    const List<String> list = <String>['Kek', 'One', 'Two', 'Three', 'Four'];
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    //getUserData();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(LineAwesomeIcons.angle_left),
        ),
        title: Text(tEditProfile,
            style: Theme.of(context).textTheme.displayMedium),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(LineAwesomeIcons.moon))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Stack(
                children: [
                  Obx(() => widget.controller.localPhoto.value.path == '/'
                      ? SizedBox(
                          width: 120,
                          height: 120,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image(
                                  image: NetworkImage(
                                      widget.controller.photo.value))),
                        )
                      : SizedBox(
                          width: 120,
                          height: 120,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image(
                                  image: FileImage(File(widget
                                      .controller.localPhoto.value.path)))),
                        )),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: tPrimaryColor),
                      child: InkWell(
                        onTap: () {
                          myAlert();
                        },
                        child: const Icon(
                          LineAwesomeIcons.camera,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Form(
                  child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                        label: Obx(() => Text(widget.controller.name.value)),
                        prefixIcon: const Icon(Icons.person_outline_rounded)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        label: Text(tAge),
                        prefixIcon: Icon(Icons.person_outline_rounded)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        label: Text(tHeight),
                        prefixIcon: Icon(Icons.person_outline_rounded)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        label: Text(tWeight),
                        prefixIcon: Icon(Icons.person_outline_rounded)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(() => DropdownButtonFormField(
                        hint: const Text(
                          'Perfil de actividades ',
                        ),
                        onChanged: (newValue) {
                          drop_con.setSelected(newValue);
                        },
                        value: drop_con.selected.value,
                        items:
                            list.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      )),
                  const SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          saveProfile().then((value) => AwesomeDialog(
                                context: context,
                                dialogType: DialogType.success,
                                animType: AnimType.rightSlide,
                                title: 'Edición del perfil',
                                desc:
                                    'Se actualizó tu información de manera exitosa',
                                btnCancelOnPress: () {},
                                btnOkOnPress: () {
                                  Get.back(result: widget.controller);
                                },
                              ).show());
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: tPrimaryColor,
                            side: BorderSide.none,
                            shape: const StadiumBorder()),
                        child: const Text(
                          tEditProfile,
                          style: TextStyle(color: tDarkColor),
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Row(
                    children: [
                      Text.rich(TextSpan(
                        text: tJoined,
                        style: TextStyle(fontSize: 12),
                        children: [
                          TextSpan(
                              text: tJoinedAt,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12))
                        ],
                      ))
                    ],
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
