import 'package:final_moviles/controllers/theme_controller.dart';
import 'package:final_moviles/firebase/facebook_autjentication.dart';
import 'package:final_moviles/firebase/google_authentication.dart';
import 'package:final_moviles/screens/Login_Screen.dart';
import 'package:final_moviles/screens/profile/update_profile_screen.dart';
import 'package:final_moviles/utils/assets_constants.dart';
import 'package:final_moviles/utils/color_constants.dart';
import 'package:final_moviles/utils/text_constants.dart';
import 'package:final_moviles/utils/theme_constants.dart';
import 'package:final_moviles/widgets/profile/profile_menu_option.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

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

  final ThemeController _themeController = Get.put(ThemeController());
  @override
  void initState() {
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController!,
            curve: const Interval(0, 0.5, curve: Curves.fastOutSlowIn)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(LineAwesomeIcons.angle_left),
        ),
        title:
            Text(tProfile, style: Theme.of(context).textTheme.headlineMedium),
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
                  SizedBox(
                    width: 100,
                    height: 100,
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
                        LineAwesomeIcons.alternate_pencil,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                tFullName,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Text(
                tEmail,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () => Get.to(() => const UpdateProfileScreen()),
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
              const SizedBox(
                height: 30,
              ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              ProfileMenuOption(
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
              ProfileMenuOption(
                  title: tMenu2,
                  icon: LineAwesomeIcons.cog,
                  onPress: () {},
                  endIcon: true),
              ProfileMenuOption(
                  title: tMenu3,
                  icon: LineAwesomeIcons.info,
                  onPress: () {},
                  endIcon: true),
              ProfileMenuOption(
                  title: tMenu4,
                  icon: LineAwesomeIcons.wallet,
                  onPress: () {},
                  endIcon: true),
              ProfileMenuOption(
                  title: tMenu5,
                  icon: LineAwesomeIcons.user_check,
                  onPress: () {},
                  endIcon: true),
            ],
          ),
        ),
      ),
    );
  }
}
