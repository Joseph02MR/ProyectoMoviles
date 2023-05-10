import 'package:final_moviles/widgets/onboarding_page.dart';
import 'package:flutter/material.dart';

class Onboarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Onboarding',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: OnboardingPage(
        pages: [
          OnboardingPageModel(
            title: 'Ejercitate, Cumple tus Metas',
            description:
                'Registra tus medidas, Sigue tu progreso y mejora tu calidad de vida.',
            image: 'assets/image0.png',
            bgColor: Colors.indigo,
          ),
          OnboardingPageModel(
            title: 'Sumergete en un nuevo estilo de vida!.',
            description: 'Lleva registro de tus comidas, adaptate, se mejor.',
            image: 'assets/image1.png',
            bgColor: const Color(0xff1eb090),
          ),
          OnboardingPageModel(
            title: 'No Olvides Guardar tu progreso',
            description:
                'Registra tus avances dentro de la aplicacion, la constancia asegura el exito.',
            image: 'assets/image2.png',
            bgColor: const Color(0xfffeae4f),
          ),
          OnboardingPageModel(
            title: 'Estira las piernas!',
            description: 'La aplicacion permitira seguir tus pasos para que logres ver cuanto has caminado, no uses siempre el auto.',
            image: 'assets/image3.png',
            bgColor: Colors.purple,
          ),
        ],
      ),
    );
  }
}
