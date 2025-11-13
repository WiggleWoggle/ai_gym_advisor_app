import 'package:ai_gym_advisor_app/pages/main/AssistantDirectMessagePage.dart';
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

class PageStack extends StatefulWidget {

  const PageStack({super.key});

  @override
  State<PageStack> createState() => _PageStackState();
}

class _PageStackState extends State<PageStack> {

  static int currentPage = 1;
  static bool signinComplete = false;

  void _changeCurrentPage(int newPage) {
    setState(() {
      currentPage = newPage;
    });
  }

  void _updateSigninCompleted(bool completed) {
    setState(() {
      signinComplete = completed;
    });
  }

  double getPageSlideOffset(int currentPage, int newPage) {

    if (currentPage == 1 && newPage == 2) {
      return -1;
    } else if (currentPage == 1 && newPage == 0) {
      return 1;
    }

    return -1;
  }

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
                AnimatedSlide(
                  offset: currentPage == 1 ? Offset(0, 0) : Offset(getPageSlideOffset(1, currentPage), 0),
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOutCubic,
                  child: HomePage(),
                ),
                AnimatedSlide(
                  offset: currentPage == 0 ? Offset(0, 0) : Offset(getPageSlideOffset(1, currentPage), 0),
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOutCubic,
                  child: AssistantDirectMessagePage(),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 40),
                    child: PageSwitcher(updatePage: _changeCurrentPage,)
                  ),
                ),
                AnimatedSlide(
                  offset: signinComplete ? Offset(0, -1) : Offset(0, 0),
                  duration: Duration(milliseconds: 600),
                  curve: Curves.easeInOutCubic,
                  child: AnimatedOpacity(
                    opacity: signinComplete ? 0 : 1,
                    duration: Duration(milliseconds: 600),
                    curve: Curves.easeInOutCubic,
                    child: SignInFormPage(updateFormCompletion: _updateSigninCompleted,),
                  )
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class PageSwitcher extends StatefulWidget {

  final ValueChanged<int> updatePage;

  PageSwitcher({Key? key, required this.updatePage}) : super(key: key);

  @override
  State<PageSwitcher> createState() => _PageSwitcher();
}

class _PageSwitcher extends State<PageSwitcher> {

  int selectedIndex = 1;

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
      widget.updatePage(index);
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

