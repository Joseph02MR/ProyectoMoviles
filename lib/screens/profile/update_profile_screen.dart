import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_moviles/controllers/dropdownbutton_controller.dart';
import 'package:final_moviles/controllers/profile_screen_controller.dart';
import 'package:final_moviles/core/animations/Fade_Animation.dart';
import 'package:final_moviles/models/profile_activities.dart';
import 'package:final_moviles/utils/color_constants.dart';
import 'package:final_moviles/utils/hexcolor.dart';
import 'package:final_moviles/utils/text_constants.dart';
import 'package:final_moviles/utils/userdata.dart';
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
  TextEditingController nameController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController ageController = TextEditingController();

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

  Future<void> saveProfile(DropdownButtonController drop_con) async {
    // Create a storage reference from our app
    String imageUrl = "";

    try {
      final storageRef = FirebaseStorage.instance.ref();

// Create a reference to "mountains.jpg"
      final mountainsRef =
          storageRef.child('${widget.controller.id}/profile.png');

      imageUrl = await mountainsRef.getDownloadURL();

      if (widget.controller.localPhoto.value.path != '/') {
        await mountainsRef
            .putFile(File(widget.controller.localPhoto.value.path));
      }
    } catch (e) {
      logger.w(e);
    }

    final userCollection = FirebaseFirestore.instance.collection('users');

    var selectedProfile = getSelectedProfile(drop_con);

    //userCollection.doc(usermail).update({
    widget.controller.localPhoto.value.path != '/'
        ? userCollection.doc(widget.controller.id).update({
            'photo': imageUrl,
            'name': nameController.text != ""
                ? nameController.text
                : widget.controller.name.value,
            'watergoal': selectedProfile['water_goal'],
            'act_profile': selectedProfile['name'],
            'age': ageController.text != ""
                ? ageController.text
                : widget.controller.age.value,
            'weight': weightController.text != ""
                ? weightController.text
                : widget.controller.weight.value,
            'height': heightController.text != ""
                ? heightController.text
                : widget.controller.height.value
          })
        : userCollection.doc(widget.controller.id).update({
            'name': nameController.text != ""
                ? nameController.text
                : widget.controller.name.value,
            'watergoal': selectedProfile['water_goal'],
            'act_profile': selectedProfile['name'],
            'age': ageController.text != ""
                ? ageController.text
                : widget.controller.age.value,
            'weight': weightController.text != ""
                ? weightController.text
                : widget.controller.weight.value,
            'height': heightController.text != ""
                ? heightController.text
                : widget.controller.height.value
          }).then((value) =>
            UserData.setData(selectedProfile['name'], widget.controller.id));
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

  Future<bool> _onWillPop() async {
    return false; //<-- SEE HERE
  }

  Map<String, dynamic> getSelectedProfile(DropdownButtonController dropCon) {
    String aux = dropCon.selected.value;

    for (var element in profiles) {
      if (element['name'] == aux) {
        return element;
      }
    }
    return Map.from({});
  }

  @override
  Widget build(BuildContext context) {
    DropdownButtonController dropCon = DropdownButtonController();

    List<String> list = List.from(profiles.map((e) => e['name']));

    //getUserData();

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Get.back(result: widget.controller),
            icon: const Icon(LineAwesomeIcons.angle_left),
          ),
          title: Text(tEditProfile,
              style: Theme.of(context).textTheme.displaySmall),
          actions: [
            IconButton(
                onPressed: () {}, icon: const Icon(LineAwesomeIcons.moon))
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: const [0.1, 0.4, 0.7, 0.9],
              colors: [
                HexColor("#4b4293").withOpacity(0.8),
                HexColor("#4b4293"),
                HexColor("#08418e"),
                HexColor("#08418e")
              ],
            ),
            image: DecorationImage(
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  HexColor("#fff").withOpacity(0.2), BlendMode.dstATop),
              image: const NetworkImage(
                'https://mir-s3-cdn-cf.behance.net/project_modules/fs/01b4bd84253993.5d56acc35e143.jpg',
              ),
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      elevation: 5,
                      color: const Color.fromARGB(255, 171, 211, 250)
                          .withOpacity(0.4),
                      child: Stack(
                        children: [
                          Obx(() => widget.controller.localPhoto.value.path ==
                                  '/'
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
                                              .controller
                                              .localPhoto
                                              .value
                                              .path)))),
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
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Form(
                        child: Column(
                      children: [
                        FadeAnimation(
                          delay: 0.8,
                          child: Container(
                            width: 300,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: TextFormField(
                              controller: nameController,
                              decoration: InputDecoration(
                                  label: Obx(
                                      () => Text(widget.controller.name.value)),
                                  prefixIcon:
                                      const Icon(Icons.person_outline_rounded)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                          delay: 0.8,
                          child: Container(
                            width: 300,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: TextFormField(
                              controller: ageController,
                              decoration: const InputDecoration(
                                  label: Text(tAge),
                                  prefixIcon:
                                      Icon(Icons.person_outline_rounded)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                          delay: 0.8,
                          child: Container(
                            width: 300,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Container(
                              width: 300,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: TextFormField(
                                controller: heightController,
                                decoration: const InputDecoration(
                                    label: Text('${tHeight}CM'),
                                    prefixIcon:
                                        Icon(Icons.person_outline_rounded)),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                          delay: 0.8,
                          child: Container(
                            width: 300,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: TextFormField(
                              controller: weightController,
                              decoration: const InputDecoration(
                                  label: Text('${tWeight}KG'),
                                  prefixIcon:
                                      Icon(Icons.person_outline_rounded)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                          delay: 0.8,
                          child: Container(
                            width: 300,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Obx(() => DropdownButtonFormField(
                                  decoration: const InputDecoration(
                                      prefixIcon:
                                          Icon(Icons.person_2_outlined)),
                                  hint: const Text(
                                    'Perfil de actividades ',
                                  ),
                                  onChanged: (newValue) {
                                    dropCon.setSelected(newValue);
                                  },
                                  value: dropCon.selected.value,
                                  items: list.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                )),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        FadeAnimation(
                          delay: 0.8,
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () {
                                  saveProfile(dropCon)
                                      .then((value) => AwesomeDialog(
                                            context: context,
                                            dialogType: DialogType.success,
                                            animType: AnimType.rightSlide,
                                            title: 'Edición del perfil',
                                            desc:
                                                'Se actualizó tu información de manera exitosa',
                                            btnCancelOnPress: () {},
                                            btnOkOnPress: () {
                                              Get.back(
                                                  result: widget.controller);
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
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12))
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
          ),
        ),
      ),
    );
  }
}
