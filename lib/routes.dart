import 'package:final_moviles/fitness_app_home_screen.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/home_fitness': (BuildContext context) => FitnessAppHomeScreen(),
  };
}
