import 'package:final_moviles/controllers/theme_controller.dart';
import 'package:final_moviles/core/animations/Fade_Animation.dart';
import 'package:final_moviles/firebase/facebook_autjentication.dart';
import 'package:final_moviles/firebase/google_authentication.dart';
import 'package:final_moviles/screens/Login_Screen.dart';
import 'package:final_moviles/screens/profile/update_profile_screen.dart';
import 'package:final_moviles/utils/assets_constants.dart';
import 'package:final_moviles/utils/color_constants.dart';
import 'package:final_moviles/utils/text_constants.dart';
import 'package:final_moviles/widgets/profile/profile_menu_option.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_moviles/controllers/profile_screen_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, this.animationController});
  final AnimationController? animationController;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Animation<double>? topBarAnimation;
  GoogleAuth googleAuth = GoogleAuth();
  FaceAuth faceAuth = FaceAuth();
  String? name;
  String? email;

  final ThemeController _themeController = Get.put(ThemeController());
  ProfileScreenController dataController = Get.put(ProfileScreenController());

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  void updateController() async {
    dataController = await Get.to(() => UpdateProfileScreen(
          controller: dataController,
        ));
  }

  @override
  void initState() {
    super.initState();
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController!,
            curve: const Interval(0, 0.5, curve: Curves.fastOutSlowIn)));
  }

  @override
  Widget build(BuildContext context) {
    Future<void> getUserData() async {
      final QuerySnapshot<Map<String, dynamic>> users = await firestore
          .collection('users')
          .where('email', isEqualTo: FirebaseAuth.instance.currentUser?.email)
          .get();

      for (final QueryDocumentSnapshot<Map<String, dynamic>> user
          in users.docs) {
        final Map<String, dynamic> data = user.data();
        dataController.email.value = data['email'];
        dataController.name.value = data['name'];
        dataController.photo.value = data['photo'];
        dataController.id = user.id;
      }
    }

    getUserData();

    Future<void> _signOut() async {
      await FirebaseAuth.instance.signOut();
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // ignore: use_build_context_synchronously
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return LoginScreen();
      }));
    }

    var isDark = _themeController.isDarkMode.value;

    final update_screen_params = <String, ProfileScreenController>{
      'controller': dataController
    };

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(LineAwesomeIcons.angle_left),
        ),
        title:
            Text(tProfile, style: Theme.of(context).textTheme.headlineSmall),
        actions: [
          IconButton(
              onPressed: () {
                /* Get.changeTheme(Get.isDarkMode
                    ? ThemeConstants.lightTheme
                    : ThemeConstants.darkTheme);*/
                _themeController.toggleTheme();
              },
              icon: Icon(isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10 /*insertar variable */),
          child: Column(
            children: [
              Stack(
                children: [
                  FadeAnimation(
                    delay: 0.8,
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Obx(() => dataController.photo.value != ''
                            ? Image(
                                image: NetworkImage(dataController.photo.value))
                            : const Image(
                                image: AssetImage(tProfileImage),
                              )),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              // ignore: unrelated_type_equality_checks
              Obx(() => FadeAnimation(
                delay: 0.8,
                child: Text(
                      dataController.name.value,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
              )),
              Obx(() => FadeAnimation(
                delay: 0.8,
                child: Text(
                      dataController.email.value,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
              )),

              const SizedBox(height: 20),
              FadeAnimation(
                delay: 0.9,
                child: SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      /*Get.to(() => UpdateProfileScreen(
                          controller: dataController,
                        ));*/
                      updateController();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: tPrimaryColor,
                        side: BorderSide.none,
                        shape: const StadiumBorder()),
                    child: const Text(
                      tEditProfile,
                      style: TextStyle(color: tDarkColor),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              FadeAnimation(
                delay: 0.9,
                child: ProfileMenuOption(
                  title: tMenu1,
                  icon: LineAwesomeIcons.alternate_sign_out,
                  onPress: () {
                    try {
                      _signOut();
                      googleAuth.signOutWithGoogle().then((value) {
                        if (value) {
                          Navigator.pop(context);
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return LoginScreen();
                          }));
                        } else {
                          print('no');
                        }
                      });
                      faceAuth.signOut().then((value) {
                        if (value) {
                          Navigator.pop(context);
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return LoginScreen();
                          }));
                        } else {
                          print('no');
                        }
                      });
                    } catch (e) {
                      print(e);
                    }
                  },
                  endIcon: false,
                  textColor: Colors.red,
                ),
              ),
              FadeAnimation(
                delay: 1,
                child: ProfileMenuOption(
                    title: tMenu2,
                    icon: LineAwesomeIcons.cog,
                    onPress: () {},
                    endIcon: true),
              ),
              FadeAnimation(
                delay: 1.1,
                child: ProfileMenuOption(
                    title: tMenu3,
                    icon: LineAwesomeIcons.info,
                    onPress: () {},
                    endIcon: true),
              ),
              FadeAnimation(
                delay: 1.2,
                child: ProfileMenuOption(
                    title: tMenu4,
                    icon: LineAwesomeIcons.wallet,
                    onPress: () {},
                    endIcon: true),
              ),
              FadeAnimation(
                delay: 1.3,
                child: ProfileMenuOption(
                    title: tMenu5,
                    icon: LineAwesomeIcons.user_check,
                    onPress: () {},
                    endIcon: true),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
