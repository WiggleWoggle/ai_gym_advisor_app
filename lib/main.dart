import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:ai_gym_advisor_app/pages/SigninFormPage.dart';
import 'package:ai_gym_advisor_app/pages/main/HomePage.dart';

void main() {
  runApp(DevicePreview(builder: (context) => MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Gym Advisor',

      home: PageStack(),
    );
  }
}

class PageStack extends StatelessWidget {

  const PageStack({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(0.0, 1.7),
                      end: Alignment(0.0, 0.2),
                      colors: [Color.fromRGBO(166, 173, 253, 0.2), Colors.white],
                    ),
                  ),
                ),
                HomePage(),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 40),
                    child: PageSwitcher()
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                      padding: EdgeInsets.only(top: 70),
                      child: LogoHeader()
                  ),
                ),
                //SignInFormPage()
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LogoHeader extends StatelessWidget {

  const LogoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/icons/logo.png',
            scale: 6,
          ),
          SizedBox(width: 12,),
          Text(
            "GymAdvisor",
            style: const TextStyle(
              fontFamily: 'InstrumentSans',
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}

class PageSwitcher extends StatefulWidget {

  PageSwitcher({Key? key}) : super(key: key);

  @override
  State<PageSwitcher> createState() => _PageSwitcher();
}

class _PageSwitcher extends State<PageSwitcher> {

  int selectedIndex = 1;

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    final double totalWidth = MediaQuery.of(context).size.width - 200;
    final double spacing = totalWidth / 3;

    return Container(
      width: totalWidth,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(80)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 20,
            offset: const Offset(0, 10),
            spreadRadius: 1,
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeInOutCubicEmphasized,
            left: (spacing * selectedIndex) + (spacing / 2) - 20,
            child: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(234, 236, 255, 1),
                    Color.fromRGBO(165, 171, 229, 1),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              tabItem('assets/icons/message.png', 0),
              tabItem('assets/icons/home.png', 1),
              tabItem('assets/icons/profile.png', 2),
            ],
          ),
        ],
      ),
    );
  }

  Widget tabItem(String assetPath, int index) {

    final bool isSelected = index == selectedIndex;

    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: TweenAnimationBuilder<Color?>(
        tween: ColorTween(
          begin: isSelected ? Colors.black : Colors.white,
          end: isSelected ? Colors.white : Colors.black,
        ),
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOutCubicEmphasized,
        builder: (context, color, _) {
          return Image.asset(
            assetPath,
            scale: isSelected ? 24 : 20,
            color: color,
          );
        },
      ),
    );
  }
}

