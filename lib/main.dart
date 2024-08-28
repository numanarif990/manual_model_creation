import 'package:flutter/material.dart';
import 'package:manual_model_creation/compex_api.dart';
import 'package:manual_model_creation/home_screen.dart';
import 'package:manual_model_creation/professional_complex_api.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: false,
        primarySwatch: Colors.blue
      ),
      home: ProfessionalComplexApi(),
    );
  }
}


