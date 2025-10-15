import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:ai_gym_advisor_app/pages/SigninFormPage.dart';

void main() {
  runApp(DevicePreview(builder: (context) => MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Gym Advisor',

      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Positioned.fill(
        child: SignInFormPage()
      ),
    );
  }
}

