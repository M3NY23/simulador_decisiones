import 'package:flutter/material.dart';
import 'package:simulador_decisiones/screens/main_screen.dart';
import 'package:simulador_decisiones/themes/principal_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: PrincipalTheme.getTheme(),
      home: const MainScreen(),
    );
  }
}
