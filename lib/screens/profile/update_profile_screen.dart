import 'package:final_moviles/controllers/dropdownbutton_controller.dart';
import 'package:final_moviles/utils/assets_constants.dart';
import 'package:final_moviles/utils/color_constants.dart';
import 'package:final_moviles/utils/text_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DropdownButtonController drop_con = DropdownButtonController();

    const List<String> list = <String>['Kek', 'One', 'Two', 'Three', 'Four'];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(LineAwesomeIcons.angle_left),
        ),
        title: Text(tEditProfile,
            style: Theme.of(context).textTheme.displayMedium),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(LineAwesomeIcons.moon))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image(image: AssetImage(tProfileImage))),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: tPrimaryColor),
                      child: const Icon(
                        LineAwesomeIcons.camera,
                        color: Colors.black,
                        size: 20,
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
                    decoration: const InputDecoration(
                        label: Text(tFullName),
                        prefixIcon: Icon(Icons.person_outline_rounded)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        label: Text(tEmail),
                        prefixIcon: Icon(Icons.person_outline_rounded)),
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
                        hint: Text(
                          'Book Type',
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
                      ))
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
