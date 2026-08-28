import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'screens/menu_screen.dart';
import 'screens/pacientes_screen.dart';
import 'screens/panel_screen.dart';
import 'screens/registro_screen.dart';
import 'screens/recuperacion_screen.dart';

import 'styles/app_theme.dart';

void main() {
  runApp(const MiApp());
}

class MiApp extends StatelessWidget {
  const MiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "NURSE",
      theme: AppTheme.theme,

      initialRoute: "/login",

      routes: {
        "/login": (context) => const HomePage(),
        "/menu": (context) => const MenuPage(),
        "/registro": (context) => const RegistroScreen(),
        "/recuperacion": (context) => const RecuperacionScreen(),
        "/pacientes": (context) => const PacientesScreen(),
        "/panel": (context) => const PanelScreen(),
      },
    );
  }
}