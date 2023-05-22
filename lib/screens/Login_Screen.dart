import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_moviles/controllers/login_screen_controller.dart';
import 'package:final_moviles/firebase/email_authentication.dart';
import 'package:final_moviles/firebase/facebook_autjentication.dart';
import 'package:final_moviles/firebase/google_authentication.dart';
import 'package:final_moviles/models/user_model.dart';
import 'package:final_moviles/screens/SignUP_Screen.dart';
import 'package:final_moviles/screens/fitness_app_home_screen.dart';
import 'package:final_moviles/screens/forgot_password_screen.dart';
import 'package:final_moviles/utils/hexcolor.dart';
import 'package:final_moviles/utils/userdata.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import '../core/animations/Fade_Animation.dart';

enum FormData {
  Email,
  password,
}

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Color enabled = const Color.fromARGB(255, 63, 56, 89);
  Color enabledtxt = Colors.white;
  Color deaible = Colors.grey;
  Color backgroundColor = const Color(0xFF1F1A30);

  Emailuth emailAuth = Emailuth();
  GoogleAuth googleAuth = GoogleAuth();
  FaceAuth faceAuth = FaceAuth();

  LoginController loginCon = LoginController();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var logger = Logger(
    printer: PrettyPrinter(),
  );

  Future<bool> checkIfAlreadySignedInWithProvider(value) async {
    List signedMethods =
        await FirebaseAuth.instance.fetchSignInMethodsForEmail(value.email!);
    if (signedMethods.isNotEmpty) {
      logger.i(signedMethods.toString());
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  elevation: 5,
                  color:
                      const Color.fromARGB(255, 171, 211, 250).withOpacity(0.4),
                  child: Container(
                    width: 400,
                    padding: const EdgeInsets.all(40.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FadeAnimation(
                          delay: 0.8,
                          child: Image.asset(
                            "assets/logo.png",
                            height: 200,
                            width: 200,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FadeAnimation(
                          delay: 1,
                          child: const Text(
                            "Por Favor, ingresa para continuar",
                            style: TextStyle(
                                color: Colors.white, letterSpacing: 0.5),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Obx(() => FadeAnimation(
                              delay: 1,
                              child: Container(
                                width: 300,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0),
                                  color: loginCon.selected.value == 'email'
                                      ? enabled
                                      : backgroundColor,
                                ),
                                padding: const EdgeInsets.all(5.0),
                                child: TextField(
                                  controller: emailController,
                                  onTap: () {
                                    loginCon.setSelected('email');
                                  },
                                  decoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    border: InputBorder.none,
                                    prefixIcon: Icon(
                                      Icons.email_outlined,
                                      color: loginCon.selected.value == 'email'
                                          ? enabledtxt
                                          : deaible,
                                      size: 20,
                                    ),
                                    hintText: 'Email',
                                    hintStyle: TextStyle(
                                        color:
                                            loginCon.selected.value == 'email'
                                                ? enabledtxt
                                                : deaible,
                                        fontSize: 12),
                                  ),
                                  textAlignVertical: TextAlignVertical.center,
                                  style: TextStyle(
                                      color: loginCon.selected.value == 'email'
                                          ? enabledtxt
                                          : deaible,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                              ),
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        Obx(() => FadeAnimation(
                              delay: 1,
                              child: Container(
                                width: 300,
                                height: 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    color: loginCon.selected.value == 'email'
                                        ? enabled
                                        : backgroundColor),
                                padding: const EdgeInsets.all(5.0),
                                child: TextField(
                                  controller: passwordController,
                                  onTap: () {
                                    loginCon.setSelected('password');
                                  },
                                  decoration: InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      border: InputBorder.none,
                                      prefixIcon: Icon(
                                        Icons.lock_open_outlined,
                                        color: loginCon.selected.value ==
                                                'password'
                                            ? enabledtxt
                                            : deaible,
                                        size: 20,
                                      ),
                                      suffixIcon: IconButton(
                                          icon: loginCon.ispasswordev.value
                                              ? Icon(
                                                  Icons.visibility_off,
                                                  color:
                                                      loginCon.selected.value ==
                                                              'password'
                                                          ? enabledtxt
                                                          : deaible,
                                                  size: 20,
                                                )
                                              : Icon(
                                                  Icons.visibility,
                                                  color:
                                                      loginCon.selected.value ==
                                                              'password'
                                                          ? enabledtxt
                                                          : deaible,
                                                  size: 20,
                                                ),
                                          onPressed: () =>
                                              loginCon.setViewablePass()),
                                      hintText: 'Password',
                                      hintStyle: TextStyle(
                                          color: loginCon.selected.value ==
                                                  'password'
                                              ? enabledtxt
                                              : deaible,
                                          fontSize: 12)),
                                  obscureText: loginCon.ispasswordev.value,
                                  textAlignVertical: TextAlignVertical.center,
                                  style: TextStyle(
                                      color:
                                          loginCon.selected.value == 'password'
                                              ? enabledtxt
                                              : deaible,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                              ),
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                          delay: 1,
                          child: SocialLoginButton(
                              buttonType: SocialLoginButtonType.google,
                              onPressed: () async {
                                UserModel? aux;
                                await googleAuth
                                    .signInWithGoogle()
                                    .then((value) {
                                  if (value.name != null) {
                                    //arguments: value
                                    aux = value;
                                  }
                                }).onError((error, stackTrace) {
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.error,
                                    animType: AnimType.rightSlide,
                                    title: 'Error de Credenciales',
                                    desc: 'Verifica tus credenciales',
                                    btnCancelOnPress: () {},
                                    btnOkOnPress: () {},
                                  ).show();
                                });
                                final userId =
                                    FirebaseAuth.instance.currentUser?.uid;

                                final userCollection = FirebaseFirestore
                                    .instance
                                    .collection('users');

                                final userDocument = userCollection.doc(userId);
                                final FirebaseFirestore firestore =
                                    FirebaseFirestore.instance;

                                final QuerySnapshot<Map<String, dynamic>>
                                    users = await firestore
                                        .collection('users')
                                        .where('email',
                                            isEqualTo: FirebaseAuth
                                                .instance.currentUser?.email)
                                        .get();
                                Map<String, dynamic> data = Map.from({});
                                for (final QueryDocumentSnapshot<
                                    Map<String, dynamic>> user in users.docs) {
                                  data = user.data();
                                  logger.i(data.toString());
                                }

                                // bool condition =
                                //     await checkIfAlreadySignedInWithProvider(
                                //         aux);
                                if (aux != null) {
                                  logger.i("$aux  ${aux?.email}");
                                  if (data["email"] ==
                                      FirebaseAuth
                                          .instance.currentUser?.email) {
                                  } else {
                                    logger.i('registered in firestore');
                                    userDocument.set({
                                      'name': aux!.name,
                                      'email': aux!.email,
                                      'photo': aux!.photoUrl,
                                      'waterdaily': 0
                                      // Add any other user information here
                                    });
                                  }

                                  UserData.setData(
                                      data['act_profile'] ?? 'baja', userId);
                                  UserData.setEmail(data['email']);

                                  Get.back();
                                  Get.to(() => FitnessAppHomeScreen());
                                }
                              },
                              backgroundColor: const Color(0xFF2697FF),
                              borderRadius: 12),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                          delay: 1,
                          child: SocialLoginButton(
                              buttonType: SocialLoginButtonType.facebook,
                              onPressed: () async {
                                faceAuth.signInWithFacebook().then((value) {
                                  if (value.name != null) {
                                    final userId =
                                        FirebaseAuth.instance.currentUser?.uid;
                                    final userCollection = FirebaseFirestore
                                        .instance
                                        .collection('users');
                                    final userDocument =
                                        userCollection.doc(userId);
                                    userDocument.update({
                                      'name': value.name,
                                      'email': value.email,
                                      'photo': value.photoUrl,
                                      // 'waterdaily': ''
                                      // Add any other user information here
                                    });
                                    Get.back();
                                    Get.to(() => FitnessAppHomeScreen());
                                  } else {
                                    AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.error,
                                      animType: AnimType.rightSlide,
                                      title: 'Error de Credenciales',
                                      desc: 'Verifica tus credenciales',
                                      btnCancelOnPress: () {},
                                      btnOkOnPress: () {},
                                    ).show();
                                  }
                                });
                              },
                              backgroundColor: const Color(0xFF2697FF),
                              borderRadius: 12),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                          delay: 1,
                          child: TextButton(
                              onPressed: () {
                                // print(emailtxt!.text);
                                // print(passwordtxt!.text);
                                emailAuth
                                    .signInWithEmailAndPassword(
                                        email: emailController!.text,
                                        password: passwordController!.text)
                                    .then((value) {
                                  if (value) {
                                    Navigator.pop(context);
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                FitnessAppHomeScreen()));
                                  } else {
                                    AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.error,
                                      animType: AnimType.rightSlide,
                                      title: 'Error de Credenciales',
                                      desc: 'Verifica tus credenciales',
                                      btnCancelOnPress: () {},
                                      btnOkOnPress: () {},
                                    ).show();
                                  }
                                });
                                // Navigator.pop(context);
                                // Navigator.of(context).push(MaterialPageRoute(
                                //     builder: (_) => FitnessAppHomeScreen()));
                              },
                              style: TextButton.styleFrom(
                                  backgroundColor: Color(0xFF2697FF),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 14.0, horizontal: 80),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(12.0))),
                              child: const Text(
                                "Inicia Sesion",
                                style: TextStyle(
                                  color: Colors.white,
                                  letterSpacing: 0.5,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),

                //End of Center Card
                //Start of outer card

                const SizedBox(
                  height: 10,
                ),
                FadeAnimation(
                  delay: 1,
                  child: GestureDetector(
                    onTap: (() {
                      Get.back();
                      /*Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return ForgotPasswordScreen();
                      }));*/
                      Get.to(() => ForgotPasswordScreen());
                    }),
                    child: Text("No puedes Ingresar?",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          letterSpacing: 0.5,
                        )),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                FadeAnimation(
                  delay: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("No tienes una Cuenta? ",
                          style: TextStyle(
                            color: Colors.grey,
                            letterSpacing: 0.5,
                          )),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                          Get.to(() => SignupScreen());
                        },
                        child: Text("Registrate",
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                                fontSize: 14)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
