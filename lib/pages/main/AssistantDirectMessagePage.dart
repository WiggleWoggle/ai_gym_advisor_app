import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ai_gym_advisor_app/pages/main/AssistantDirectMessagePage.dart';

import '../aiassistant/AIChatMessages.dart';

class AssistantDirectMessagePage extends StatefulWidget {

  final VoidCallback? toggleDarkMode;
  final Function()? getIsDarkMode;

  const AssistantDirectMessagePage({super.key, required this.toggleDarkMode, required this.getIsDarkMode});

  @override
  State<AssistantDirectMessagePage> createState() =>
      _AssistantDirectMessagePageState();
}

class _AssistantDirectMessagePageState extends State<AssistantDirectMessagePage> {

  bool blurBackground = false;
  bool settingsPage = false;

  void toggleBlurredBackground() {
    setState(() {
      blurBackground = !blurBackground;
    });
  }

  void toggleSettingsPage() {
    setState(() {
      settingsPage = !settingsPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(0.0, 1.7),
                end: Alignment(0.0, 0.2),
                colors: [
                  widget.getIsDarkMode!() ? Color.fromRGBO(45, 46, 59, 1) : Color.fromRGBO(166, 173, 253, 0.2),
                  widget.getIsDarkMode!() ? Color.fromRGBO(61, 61, 61, 1) : Colors.white
                ],
              ),
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: ConversationColumn(
                    isDarkMode: widget.getIsDarkMode!(),
                  ),
                ),
                AnimatedOpacity(
                  opacity: blurBackground ? 1 : 0,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOutCubic,
                  child: Container(
                    color: Color.fromRGBO(217, 217, 217, 0.7),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.14,
                    ),
                    child: MessageBox(
                      blurBackgroundMethod: toggleBlurredBackground,
                    ),
                  ),
                ),
              ],
            )
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.14,
              color: widget.getIsDarkMode!() ? Color.fromRGBO(61, 61, 61, 1) : Colors.white,
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(
                    right: MediaQuery.of(context).size.height * 0.025,
                    top: MediaQuery.of(context).size.height * 0.053
                ),
                child: GestureDetector(
                  onTap: toggleSettingsPage,
                  child: Image.asset(
                    'assets/icons/menuright.png',
                    scale: MediaQuery.of(context).size.width * 0.05,
                    color: widget.getIsDarkMode!() ? Colors.white : Color.fromRGBO(75, 75, 75, 1),
                  ),
                )
              ),
            )
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
                padding: EdgeInsets.only(top: 70),
                child: LogoHeader(
                  isDarkMode: widget.getIsDarkMode!(),
                )
            ),
          ),
          IgnorePointer(
            child: AnimatedOpacity(
              opacity: settingsPage ? 1 : 0,
              duration: Duration(milliseconds: 600),
              curve: Curves.easeInOutCubic,
              child: Container(
                color: widget.getIsDarkMode!() ? Color.fromRGBO(83, 83, 83, 0.7) : Color.fromRGBO(217, 217, 217, 0.7),
              ),
            ),
          ),
          AnimatedSlide(
            offset: Offset(0, settingsPage ? 0 : MediaQuery.of(context).size.height * 0.002),
            curve: Curves.easeInOutCubic,
            duration: Duration(milliseconds: 600),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: AdvisorSettingsWidget(
                toggleSettingsPage: toggleSettingsPage,
                getIsDarkMode: widget.getIsDarkMode,
                toggleDarkMode: widget.toggleDarkMode,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AdvisorSettingsWidget extends StatefulWidget {

  final VoidCallback? toggleSettingsPage;
  final VoidCallback? toggleDarkMode;
  final Function()? getIsDarkMode;
  const AdvisorSettingsWidget({super.key, this.toggleSettingsPage, required this.getIsDarkMode, required this.toggleDarkMode});

  @override
  State<AdvisorSettingsWidget> createState() => _AdvisorSettingsWidgetState();
}

class _AdvisorSettingsWidgetState extends State<AdvisorSettingsWidget> {

  int currentPageView = 0;

  void updateCurrentPageView(int newPage) {
    setState(() {
      currentPageView = newPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      curve: Curves.easeInOutCubic,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.92,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.0, 1),
          end: Alignment(0.0, 0),
            colors: [
              widget.getIsDarkMode!() ? Color(0xFF2D2E3B) : Color(0xFFEAECFB),
              widget.getIsDarkMode!() ? Color(0xFF3D3D3D) : Colors.white,
            ]
        ),
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(45),
          topRight: const Radius.circular(45),
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedSlide(
            offset: isCurrentPage(1) ? Offset(0, 0) : Offset(MediaQuery.of(context).size.width * 0.003, 0),
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOutCubic,
            child: ChatLanguageSettingsPage(
              updateCurrentPageView: updateCurrentPageView,
              getIsDarkMode: widget.getIsDarkMode,
            ),
          ),
          AnimatedSlide(
            offset: isCurrentPage(2) ? Offset(0, 0) : Offset(MediaQuery.of(context).size.width * 0.003, 0),
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOutCubic,
            child: ArchiveSettingsPage(
              updateCurrentPageView: updateCurrentPageView,
                getIsDarkMode: widget.getIsDarkMode
            ),
          ),
          AnimatedSlide(
            offset: isCurrentPage(0) ? Offset(0, 0) : Offset(-MediaQuery.of(context).size.width * 0.003, 0),
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOutCubic,
            child: SettingsLandingPage(
              updateCurrentPageView: updateCurrentPageView,
              toggleSettingsPage: widget.toggleSettingsPage,
                getIsDarkMode: widget.getIsDarkMode,
              toggleDarkMode: widget.toggleDarkMode,
            ),
          ),
        ],
      )
    );
  }

  bool isCurrentPage(int pageID) {
    if (pageID == currentPageView) {
      return true;
    }

    return false;
  }
}

class ArchiveSettingsPage extends StatefulWidget {

  final Function(int)? updateCurrentPageView;
  final Function()? getIsDarkMode;
  const ArchiveSettingsPage({super.key, this.updateCurrentPageView, required this.getIsDarkMode});

  @override
  State<ArchiveSettingsPage> createState() => _ArchiveSettingsPageState();
}

class _ArchiveSettingsPageState extends State<ArchiveSettingsPage> {

  int selectedID = -1;

  void updatedSelectedID(int id) {
    setState(() {
      if (selectedID == id) {
        selectedID = -1;
      } else {
        selectedID = id;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.027),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.04,
                  child: GestureDetector(
                    onTap: () => widget.updateCurrentPageView!(0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Icon(Icons.arrow_back_ios_rounded, size: 22, color: Color.fromRGBO(140, 140, 144, 1),)
                    ),
                  )
              ),
              Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: MediaQuery.of(context).size.height * 0.04,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Archived Chats",
                      style: TextStyle(
                        fontFamily: 'InstrumentSans',
                        color: widget.getIsDarkMode!() ? Colors.white : Color.fromRGBO(75, 75, 75, 1),
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
              ),
            ],
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.05,
          height: MediaQuery.of(context).size.width * 0.09,
        ),
        Expanded(
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                  scrollbars: false
              ),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () => updatedSelectedID(0),
                      child: ArchivedChatWidget(
                        senderName: "AI Advisor",
                        senderProfilePic: "assets/icons/logo.png",
                        messageText: 'Sounds good! Here’s a list of workouts...',
                        id: 0,
                        selectedID: selectedID,
                        isDarkMode: widget.getIsDarkMode!(),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => updatedSelectedID(1),
                      child: ArchivedChatWidget(
                        senderName: "You",
                        senderProfilePic: "assets/icons/defaultUser.png",
                        messageText: 'Can you give me a list of workouts that...',
                        id: 1,
                        selectedID: selectedID,
                        isDarkMode: widget.getIsDarkMode!(),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => updatedSelectedID(2),
                      child: ArchivedChatWidget(
                        senderName: "AI Advisor",
                        senderProfilePic: "assets/icons/logo.png",
                        messageText: 'Sorry, I can\'t help with that!',
                        id: 2,
                        selectedID: selectedID,
                        isDarkMode: widget.getIsDarkMode!(),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => updatedSelectedID(3),
                      child: ArchivedChatWidget(
                        senderName: "AI Advisor",
                        senderProfilePic: "assets/icons/logo.png",
                        messageText: 'Sorry, I can\'t help with that!',
                        id: 3,
                        selectedID: selectedID,
                        isDarkMode: widget.getIsDarkMode!(),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => updatedSelectedID(4),
                      child: ArchivedChatWidget(
                        senderName: "AI Advisor",
                        senderProfilePic: "assets/icons/logo.png",
                        messageText: 'Sorry, I can\'t help with that!',
                        id: 4,
                        selectedID: selectedID,
                        isDarkMode: widget.getIsDarkMode!(),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => updatedSelectedID(5),
                      child: ArchivedChatWidget(
                        senderName: "AI Advisor",
                        senderProfilePic: "assets/icons/logo.png",
                        messageText: 'Sorry, I can\'t help with that!',
                        id: 5,
                        selectedID: selectedID,
                        isDarkMode: widget.getIsDarkMode!(),
                      ),
                    )
                  ],
                ),
              ),
            )
        ),

        SettingsOptionButton(
            buttonIcon: CupertinoIcons.arrow_turn_up_left,
            buttonText: "Unarchive all",
            hasSubMenu: false,
            hasSubMenuText: false,
            subMenuText: "Null",
            textColor: Color.fromRGBO(88, 171, 92, 1),
            hasToggleButton: false,
            backgroundColor: widget.getIsDarkMode!() ? Color.fromRGBO(63, 63, 63, 1) : Colors.white
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.015,
          width: MediaQuery.of(context).size.height * 0.015,
        ),
        SettingsOptionButton(
            buttonIcon: CupertinoIcons.trash,
            buttonText: "Delete all",
            hasSubMenu: false,
            hasSubMenuText: false,
            subMenuText: "Null",
            textColor: Color.fromRGBO(255, 155, 155, 1),
            hasToggleButton: false,
            backgroundColor: widget.getIsDarkMode!() ? Color.fromRGBO(63, 63, 63, 1) : Colors.white
        )
      ],
    );
  }
}

class ChatLanguageSettingsPage extends StatefulWidget {

  final Function(int)? updateCurrentPageView;
  final Function()? getIsDarkMode;
  const ChatLanguageSettingsPage({super.key, this.updateCurrentPageView, required this.getIsDarkMode});

  @override
  State<ChatLanguageSettingsPage> createState() => _ChatLanguageSettingsPageState();
}

class _ChatLanguageSettingsPageState extends State<ChatLanguageSettingsPage> {

  int selectedID = 0;

  void updateSelectedID(int newID) {
    setState(() {
      selectedID = newID;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.027),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.04,
                  child: GestureDetector(
                    onTap: () => widget.updateCurrentPageView!(0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Icon(Icons.arrow_back_ios_rounded, size: 22, color: Color.fromRGBO(140, 140, 144, 1),)
                    ),
                  )
              ),
              Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: MediaQuery.of(context).size.height * 0.04,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Chat Language",
                      style: TextStyle(
                        fontFamily: 'InstrumentSans',
                        color: widget.getIsDarkMode!() ? Colors.white : Color.fromRGBO(75, 75, 75, 1),
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
              ),
            ],
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.05,
          height: MediaQuery.of(context).size.width * 0.09,
        ),
        Expanded(
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              scrollbars: false
            ),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  SelectableSettingsOptionWidget(
                    optionText: "English",
                    id: 0,
                    selectedID: selectedID,
                    updateSelectedID: updateSelectedID,
                    isDarkMode: widget.getIsDarkMode!(),
                  ),
                  SelectableSettingsOptionWidget(
                    optionText: "Spanish",
                    id: 1,
                    selectedID: selectedID,
                    updateSelectedID: updateSelectedID,
                    isDarkMode: widget.getIsDarkMode!(),
                  ),
                  SelectableSettingsOptionWidget(
                    optionText: "French",
                    id: 2,
                    selectedID: selectedID,
                    updateSelectedID: updateSelectedID,
                    isDarkMode: widget.getIsDarkMode!(),
                  ),
                  SelectableSettingsOptionWidget(
                    optionText: "Chinese",
                    id: 3,
                    selectedID: selectedID,
                    updateSelectedID: updateSelectedID,
                    isDarkMode: widget.getIsDarkMode!(),
                  ),
                  SelectableSettingsOptionWidget(
                    optionText: "Japanese",
                    id: 4,
                    selectedID: selectedID,
                    updateSelectedID: updateSelectedID,
                    isDarkMode: widget.getIsDarkMode!(),
                  ),
                  SelectableSettingsOptionWidget(
                    optionText: "Vietnamese",
                    id: 5,
                    selectedID: selectedID,
                    updateSelectedID: updateSelectedID,
                    isDarkMode: widget.getIsDarkMode!(),
                  ),
                  SelectableSettingsOptionWidget(
                    optionText: "German",
                    id: 6,
                    selectedID: selectedID,
                    updateSelectedID: updateSelectedID,
                    isDarkMode: widget.getIsDarkMode!(),
                  ),
                  SelectableSettingsOptionWidget(
                    optionText: "Arabic",
                    id: 7,
                    selectedID: selectedID,
                    updateSelectedID: updateSelectedID,
                    isDarkMode: widget.getIsDarkMode!(),
                  ),
                  SelectableSettingsOptionWidget(
                    optionText: "Taiwanese",
                    id: 8,
                    selectedID: selectedID,
                    updateSelectedID: updateSelectedID,
                    isDarkMode: widget.getIsDarkMode!(),
                  ),
                  SelectableSettingsOptionWidget(
                    optionText: "Korean",
                    id: 9,
                    selectedID: selectedID,
                    updateSelectedID: updateSelectedID,
                    isDarkMode: widget.getIsDarkMode!(),
                  ),
                  SelectableSettingsOptionWidget(
                    optionText: "Portuguese",
                    id: 10,
                    selectedID: selectedID,
                    updateSelectedID: updateSelectedID,
                    isDarkMode: widget.getIsDarkMode!(),
                  ),
                  SelectableSettingsOptionWidget(
                    optionText: "Italian",
                    id: 11,
                    selectedID: selectedID,
                    updateSelectedID: updateSelectedID,
                    isDarkMode: widget.getIsDarkMode!(),
                  ),
                  SelectableSettingsOptionWidget(
                    optionText: "Russian",
                    id: 12,
                    selectedID: selectedID,
                    updateSelectedID: updateSelectedID,
                    isDarkMode: widget.getIsDarkMode!(),
                  ),
                  SelectableSettingsOptionWidget(
                    optionText: "Hindi",
                    id: 13,
                    selectedID: selectedID,
                    updateSelectedID: updateSelectedID,
                    isDarkMode: widget.getIsDarkMode!(),
                  )
                ],
              ),
            ),
          )
        )
      ],
    );
  }
}

class SettingsLandingPage extends StatefulWidget {

  final VoidCallback? toggleSettingsPage;
  final Function(int)? updateCurrentPageView;
  final Function()? getIsDarkMode;
  final VoidCallback? toggleDarkMode;
  const SettingsLandingPage({super.key, this.toggleSettingsPage, this.updateCurrentPageView, required this.getIsDarkMode, required this.toggleDarkMode});

  @override
  State<SettingsLandingPage> createState() => _SettingsLandingPageState();
}

class _SettingsLandingPageState extends State<SettingsLandingPage> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.027),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.04,
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: widget.toggleSettingsPage,
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 400),
                          curve: Curves.easeInOutCubic,
                          width: MediaQuery.of(context).size.width * 0.08,
                          height: MediaQuery.of(context).size.width * 0.08,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: widget.getIsDarkMode!() ? Color.fromRGBO(110, 110, 110, 1) : Color.fromRGBO(229, 229, 234, 1)
                          ),
                          child: TweenAnimationBuilder<Color?>(
                            tween: ColorTween(
                              begin: widget.getIsDarkMode!()
                                  ? Color.fromRGBO(140, 140, 144, 1)
                                  : Color.fromRGBO(233, 233, 233, 1),
                              end: widget.getIsDarkMode!()
                                  ? Color.fromRGBO(233, 233, 233, 1)
                                  : Color.fromRGBO(140, 140, 144, 1),
                            ),
                            duration: Duration(milliseconds: 400),
                            builder: (context, color, child) {
                              return Icon(
                                Icons.close,
                                size: 22,
                                color: color,
                              );
                            },
                          )
                        ),
                      )
                  )
              ),
              Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: MediaQuery.of(context).size.height * 0.04,
                  child: Align(
                    alignment: Alignment.center,
                    child: AnimatedDefaultTextStyle(
                      duration: Duration(milliseconds: 400),
                      curve: Curves.easeInOutCubic,
                      style: TextStyle(
                        fontFamily: 'InstrumentSans',
                        color: widget.getIsDarkMode!() ? Colors.white : Color.fromRGBO(75, 75, 75, 1),
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                        fontWeight: FontWeight.bold,
                      ),
                      child: Text("AI Advisor Settings"),
                    ),
                  )
              ),
            ],
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.05,
          height: MediaQuery.of(context).size.width * 0.05,
        ),
        Container(
            width: MediaQuery.of(context).size.width * 0.84,
            height: MediaQuery.of(context).size.height * 0.05,
            child: Align(
              alignment: Alignment.centerLeft,
              child: AnimatedDefaultTextStyle(
                duration: Duration(milliseconds: 400),
                curve: Curves.easeInOutCubic,
                style: TextStyle(
                  fontFamily: 'InstrumentSans',
                  color: widget.getIsDarkMode!() ? Colors.white : Color.fromRGBO(64, 64, 64, 1),
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                  fontWeight: FontWeight.bold,
                ),
                child: Text("Chat Info",),
              ),
            )
        ),
        InfoWidget(
          getIsDarkMode: widget.getIsDarkMode,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.08,
          height: MediaQuery.of(context).size.width * 0.08,
        ),
        Container(
            width: MediaQuery.of(context).size.width * 0.84,
            height: MediaQuery.of(context).size.height * 0.05,
            child: Align(
              alignment: Alignment.centerLeft,
              child: AnimatedDefaultTextStyle(
                duration: Duration(milliseconds: 400),
                curve: Curves.easeInOutCubic,
                style: TextStyle(
                  fontFamily: 'InstrumentSans',
                  color: widget.getIsDarkMode!() ? Colors.white : Color.fromRGBO(64, 64, 64, 1),
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                  fontWeight: FontWeight.bold,
                ),
                child: Text("Chat Settings"),
              ),
            )
        ),
        GestureDetector(
          onTap: () => widget.updateCurrentPageView!(1),
          child: SettingsOptionButton(
            buttonIcon: CupertinoIcons.globe,
            buttonText: "Chat Language",
            hasSubMenu: true,
            hasSubMenuText: true,
            subMenuText: "English",
            hasToggleButton: false,
            textColor: widget.getIsDarkMode!() ? Colors.white : Color.fromRGBO(64, 64, 64, 1),
            backgroundColor: widget.getIsDarkMode!() ? Color.fromRGBO(69, 69, 69, 1) : Colors.white,
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.04,
          height: MediaQuery.of(context).size.width * 0.04,
        ),
        GestureDetector(
          onTap: () => widget.updateCurrentPageView!(2),
          child: SettingsOptionButton(
            buttonIcon: CupertinoIcons.archivebox,
            buttonText: "Archived Chats",
            hasSubMenu: true,
            hasSubMenuText: false,
            subMenuText: "English",
            hasToggleButton: false,
            textColor: widget.getIsDarkMode!() ? Colors.white : Color.fromRGBO(64, 64, 64, 1),
            backgroundColor: widget.getIsDarkMode!() ? Color.fromRGBO(69, 69, 69, 1) : Colors.white,
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.04,
          height: MediaQuery.of(context).size.width * 0.04,
        ),
        SettingsOptionButton(
          buttonIcon: CupertinoIcons.sun_min,
          buttonText: "Dark Mode",
          hasSubMenu: false,
          hasSubMenuText: false,
          subMenuText: "English",
          hasToggleButton: true,
          toggleOnMethod: widget.toggleDarkMode,
          textColor: widget.getIsDarkMode!() ? Colors.white : Color.fromRGBO(64, 64, 64, 1),
          backgroundColor: widget.getIsDarkMode!() ? Color.fromRGBO(69, 69, 69, 1) : Colors.white,

        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.08,
          height: MediaQuery.of(context).size.width * 0.08,
        ),
        Container(
            width: MediaQuery.of(context).size.width * 0.84,
            height: MediaQuery.of(context).size.height * 0.05,
            child: Align(
              alignment: Alignment.centerLeft,
              child: AnimatedDefaultTextStyle(
                duration: Duration(milliseconds: 400),
                curve: Curves.easeInOutCubic,
                style: TextStyle(
                  fontFamily: 'InstrumentSans',
                  color: widget.getIsDarkMode!() ? Colors.white : Color.fromRGBO(64, 64, 64, 1),
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                  fontWeight: FontWeight.bold,
                ),
                child: Text("Privacy",),
              ),
            )
        ),
        SettingsOptionButton(
          buttonIcon: Icons.menu_rounded,
          buttonText: "Terms of Service",
          hasSubMenu: false,
          hasSubMenuText: false,
          subMenuText: "English",
          hasToggleButton: false,
          textColor: widget.getIsDarkMode!() ? Colors.white : Color.fromRGBO(64, 64, 64, 1),
          backgroundColor: widget.getIsDarkMode!() ? Color.fromRGBO(69, 69, 69, 1) : Colors.white,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.04,
          height: MediaQuery.of(context).size.width * 0.04,
        ),
        SettingsOptionButton(
          buttonIcon: CupertinoIcons.trash,
          buttonText: "Delete Chats",
          hasSubMenu: false,
          hasSubMenuText: false,
          subMenuText: "English",
          hasToggleButton: false,
          textColor: Color.fromRGBO(255, 155, 155, 1),
          backgroundColor: widget.getIsDarkMode!() ? Color.fromRGBO(69, 69, 69, 1) : Colors.white,
        ),
      ],
    );
  }
}

class ArchivedChatWidget extends StatefulWidget {

  final String senderName;
  final String senderProfilePic;
  final String messageText;

  final int id;
  final int selectedID;

  final bool isDarkMode;

  const ArchivedChatWidget({super.key, required this.senderName, required this.messageText, required this.senderProfilePic, required this.id, required this.selectedID, required this.isDarkMode});

  @override
  State<ArchivedChatWidget> createState() => _ArchivedChatWidgetState();
}

class _ArchivedChatWidgetState extends State<ArchivedChatWidget> {

  bool isExpanded() {
    return widget.id == widget.selectedID;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.93,
              height: MediaQuery.of(context).size.height * 0.053,
            ),
            AnimatedScale(
              scale: isExpanded() ? 1.02 : 1,
              curve: Curves.easeInOutCubic,
              duration: Duration(milliseconds: 300),
              child: Stack(
                children: [
                  AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      curve: Curves.easeInOutCubic,
                      width: MediaQuery.of(context).size.width * 0.87,
                      height: MediaQuery.of(context).size.height * 0.078,
                      decoration: BoxDecoration(
                        color: widget.isDarkMode ? Color.fromRGBO(63, 63, 63, 1) : Colors.white,
                        borderRadius: const BorderRadius.all(Radius.circular(12)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.025),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                                ClipOval(
                                  child: Image.asset(
                                    widget.senderProfilePic,
                                    width: MediaQuery.of(context).size.width * 0.1,
                                    height: MediaQuery.of(context).size.width * 0.1,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      widget.senderName,
                                      style: TextStyle(
                                        fontFamily: 'InstrumentSans',
                                        color: widget.isDarkMode ? Colors.white : Color.fromRGBO(64, 64, 64, 1),
                                        fontSize: MediaQuery.of(context).size.width * 0.04,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      widget.messageText,
                                      style: TextStyle(
                                        fontFamily: 'InstrumentSans',
                                        color: widget.isDarkMode ? Color.fromRGBO(180, 180, 180, 1) : Color.fromRGBO(140, 140, 140, 1),
                                        fontSize: MediaQuery.of(context).size.width * 0.03,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                AnimatedRotation(
                                  turns: isExpanded() ? 0.5 : 0,
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.easeInOutCubic,
                                  child: Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    size: MediaQuery.of(context).size.width * 0.065,
                                    color: widget.isDarkMode ? Color.fromRGBO(180, 180, 180, 1) : Color.fromRGBO(140, 140, 140, 1),
                                  ),
                                ),
                                SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                              ],
                            )
                        ),
                      )
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 400),
                    curve: Curves.easeInOutCubic,
                    width: MediaQuery.of(context).size.width * 0.87,
                    height: MediaQuery.of(context).size.height * 0.078,
                    decoration: BoxDecoration(
                      color: _getBackgroundColor(),
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                ],
              )
            ),
            Positioned(
              right: MediaQuery.of(context).size.width * 0.05,
              top: isExpanded() ? MediaQuery.of(context).size.height * 0.01 : 0,
              child: Row(
                children: [
                  AnimatedScale(
                    scale: isExpanded() ? 1 : 0,
                    duration: Duration(milliseconds: 400),
                    curve: Curves.easeOutCubic,
                    child: AnimatedSlide(
                      offset: Offset(0, isExpanded() ? MediaQuery.of(context).size.height * 0.0018 : 0),
                      curve: Curves.easeInOutCubic,
                      duration: Duration(milliseconds: 400),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.1,
                        height: MediaQuery.of(context).size.width * 0.1,
                        decoration: BoxDecoration(
                          color: widget.isDarkMode ? Color.fromRGBO(83, 83, 83, 1) : Colors.white,
                          borderRadius: const BorderRadius.all(Radius.circular(90)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: Icon(CupertinoIcons.arrow_turn_up_left, size: MediaQuery.of(context).size.width * 0.06, color: Color.fromRGBO(88, 171, 92, 1),),
                      ),
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.025),
                  AnimatedScale(
                    scale: isExpanded() ? 1 : 0,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeOutCubic,
                    child: AnimatedSlide(
                      offset: Offset(0, isExpanded() ? MediaQuery.of(context).size.height * 0.0018 : 0),
                      curve: Curves.easeInOutCubic,
                      duration: Duration(milliseconds: 300),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.1,
                        height: MediaQuery.of(context).size.width * 0.1,
                        decoration: BoxDecoration(
                          color: widget.isDarkMode ? Color.fromRGBO(83, 83, 83, 1) : Colors.white,
                          borderRadius: const BorderRadius.all(Radius.circular(90)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: Icon(CupertinoIcons.trash, size: MediaQuery.of(context).size.width * 0.06, color: Color.fromRGBO(255, 155, 155, 1),),
                      ),
                    ),
                  )
                ],
              ),
            ),

          ],
        ),
        AnimatedSize(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOutCubic,
          child: SizedBox(
            height: isExpanded()
                ? MediaQuery.of(context).size.width * 0.15
                : MediaQuery.of(context).size.width * 0.04,
            width: MediaQuery.of(context).size.width * 0.04,
          ),
        )
      ],
    );
  }

  Color _getBackgroundColor() {
    if (widget.selectedID == -1) {
      return widget.isDarkMode ? Color.fromRGBO(63, 63, 63, 0) : Color.fromRGBO(255, 255, 255, 0);
    } else if (widget.id == widget.selectedID) {
      return widget.isDarkMode ? Color.fromRGBO(63, 63, 63, 0) : Color.fromRGBO(255, 255, 255, 0);
    } else {
      return widget.isDarkMode ? Color.fromRGBO(63, 63, 63, 0.7) : Color.fromRGBO(255, 255, 255, 0.7);
    }
  }
}

class SelectableSettingsOptionWidget extends StatefulWidget {

  final int id;
  final int selectedID;
  final String optionText;

  final Function(int)? updateSelectedID;

  final bool isDarkMode;

  const SelectableSettingsOptionWidget({super.key, required this.optionText, required this.id, required this.selectedID, this.updateSelectedID, required this.isDarkMode});

  @override
  State<SelectableSettingsOptionWidget> createState() => _SelectableSettingsOptionWidgetState();
}

class _SelectableSettingsOptionWidgetState extends State<SelectableSettingsOptionWidget> {

  bool selected() {
    return widget.id == widget.selectedID;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.93,
              height: MediaQuery.of(context).size.height * 0.053,
            ),
            GestureDetector(
              onTap: () => widget.updateSelectedID!(widget.id),
              child: AnimatedScale(
                scale: selected() ? 1.02 : 1.0,
                curve: Curves.elasticOut,
                duration: Duration(milliseconds: 400),
                child: AnimatedContainer(
                    duration: Duration(milliseconds: 160),
                    curve: Curves.easeInOutCubic,
                    width: MediaQuery.of(context).size.width * 0.87,
                    height: MediaQuery.of(context).size.height * 0.053,
                    decoration: BoxDecoration(
                      color: selected() ? Color.fromRGBO(166, 173, 253, 1) : widget.isDarkMode ? Color.fromRGBO(63, 63, 63, 1) : Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.025),
                        child: Row(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.width * 0.02,
                              width: MediaQuery.of(context).size.width * 0.02,
                            ),
                            Text(
                              widget.optionText,
                              style: TextStyle(
                                fontFamily: 'InstrumentSans',
                                color: widget.isDarkMode ? selected() ? Color.fromRGBO(64, 64, 64, 1) : Colors.white : Color.fromRGBO(64, 64, 64, 1),
                                fontSize: MediaQuery.of(context).size.width * 0.04,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                ),
              )
            )
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.width * 0.06,
          width: MediaQuery.of(context).size.width * 0.04,
        )
      ],
    );
  }
}

class InfoWidget extends StatelessWidget {

  final Function()? getIsDarkMode;
  const InfoWidget({super.key, required this.getIsDarkMode});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: Duration(milliseconds: 400),
        curve: Curves.easeInOutCubic,
        width: MediaQuery.of(context).size.width * 0.87,
        height: MediaQuery.of(context).size.height * 0.14,
        decoration: BoxDecoration(
          color: getIsDarkMode!() ? Color.fromRGBO(64, 64, 64, 1) : Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 20,
              offset: const Offset(0, 10),
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.025),
                child: Row(
                  children: [
                    TweenAnimationBuilder<Color?>(
                      tween: ColorTween(
                        begin: getIsDarkMode!() ? Color.fromRGBO(64, 64, 64, 1) : Colors.white,
                        end: getIsDarkMode!() ? Colors.white : Color.fromRGBO(64, 64, 64, 1),
                      ),
                      duration: Duration(milliseconds: 400),
                      curve: Curves.easeInOutCubic,
                      builder: (context, color, child) {
                        return Icon(
                          Icons.info_outline_rounded,
                          size: MediaQuery.of(context).size.height * 0.025,
                          color: color,
                        );
                      },
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.025,
                      height: MediaQuery.of(context).size.width * 0.025,
                    ),
                    AnimatedDefaultTextStyle(
                      duration: Duration(milliseconds: 400),
                      curve: Curves.easeInOutCubic,
                      style: TextStyle(
                        fontFamily: 'InstrumentSans',
                        color: getIsDarkMode!() ? Colors.white : Color.fromRGBO(64, 64, 64, 1),
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                        fontWeight: FontWeight.bold,
                      ),
                      child: Text("107 chats sent"),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.03,
              height: MediaQuery.of(context).size.width * 0.03,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.025),
                child: Row(
                  children: [
                    TweenAnimationBuilder<Color?>(
                      tween: ColorTween(
                        begin: getIsDarkMode!() ? Color.fromRGBO(64, 64, 64, 1) : Colors.white,
                        end: getIsDarkMode!() ? Colors.white : Color.fromRGBO(64, 64, 64, 1),
                      ),
                      duration: Duration(milliseconds: 400),
                      curve: Curves.easeInOutCubic,
                      builder: (context, color, child) {
                        return Icon(
                          Icons.thumb_up_alt_outlined,
                          size: MediaQuery.of(context).size.height * 0.025,
                          color: color,
                        );
                      },
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.025,
                      height: MediaQuery.of(context).size.width * 0.025,
                    ),
                    AnimatedDefaultTextStyle(
                      duration: Duration(milliseconds: 400),
                      curve: Curves.easeInOutCubic,
                      style: TextStyle(
                        fontFamily: 'InstrumentSans',
                        color: getIsDarkMode!() ? Colors.white : Color.fromRGBO(64, 64, 64, 1),
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                        fontWeight: FontWeight.bold,
                      ),
                      child: Text("81 chats marked supported"),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.03,
              height: MediaQuery.of(context).size.width * 0.03,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.025),
                child: Row(
                  children: [
                    TweenAnimationBuilder<Color?>(
                      tween: ColorTween(
                        begin: getIsDarkMode!() ? Color.fromRGBO(64, 64, 64, 1) : Colors.white,
                        end: getIsDarkMode!() ? Colors.white : Color.fromRGBO(64, 64, 64, 1),
                      ),
                      duration: Duration(milliseconds: 400),
                      curve: Curves.easeInOutCubic,
                      builder: (context, color, child) {
                        return Icon(
                          Icons.thumb_down_off_alt_rounded,
                          size: MediaQuery.of(context).size.height * 0.025,
                          color: color,
                        );
                      },
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.025,
                      height: MediaQuery.of(context).size.width * 0.025,
                    ),
                    AnimatedDefaultTextStyle(
                      duration: Duration(milliseconds: 400),
                      curve: Curves.easeInOutCubic,
                      style: TextStyle(
                        fontFamily: 'InstrumentSans',
                        color: getIsDarkMode!() ? Colors.white : Color.fromRGBO(64, 64, 64, 1),
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                        fontWeight: FontWeight.bold,
                      ),
                      child: Text("26 chats marked unsupported",),
                    ),
                  ],
                ),
              ),
            )
          ],
        )
    );
  }
}

class SettingsOptionButton extends StatefulWidget {

  final IconData buttonIcon;
  final String buttonText;

  final Color textColor;
  final Color backgroundColor;

  final bool hasSubMenu;
  final bool hasSubMenuText;
  final String subMenuText;

  final bool hasToggleButton;
  final VoidCallback? toggleOnMethod;

  const SettingsOptionButton({super.key, required this.buttonIcon, required this.buttonText, required this.hasSubMenu, required this.hasSubMenuText, required this.subMenuText, required this.textColor, required this.hasToggleButton, required this.backgroundColor, this.toggleOnMethod});

  @override
  State<SettingsOptionButton> createState() => _SettingsOptionButtonState();
}

class _SettingsOptionButtonState extends State<SettingsOptionButton> {

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      curve: Curves.easeInOutCubic,
      width: MediaQuery.of(context).size.width * 0.87,
      height: MediaQuery.of(context).size.height * 0.053,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
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
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.025),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (widget.hasSubMenuText)
                    Text(
                      widget.subMenuText,
                      style: TextStyle(
                        fontFamily: 'InstrumentSans',
                        color: Color.fromRGBO(195, 195, 195, 1),
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  if (widget.hasSubMenuText)
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.01,
                      height: MediaQuery.of(context).size.width * 0.01,
                    ),
                  if (widget.hasSubMenu)
                    Icon(
                      Icons.navigate_next_rounded,
                      size: MediaQuery.of(context).size.height * 0.03,
                      color: Color.fromRGBO(195, 195, 195, 1),
                    ),
                  if (widget.hasToggleButton)
                    ToggleButtonWidget(
                      toggleOnMethod: widget.toggleOnMethod,
                    )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.025),
              child: Row(
                children: [
                  TweenAnimationBuilder<Color?>(
                    tween: ColorTween(
                      begin: widget.textColor,
                      end: widget.textColor,
                    ),
                    duration: Duration(milliseconds: 400),
                    curve: Curves.easeInOutCubic,
                    builder: (context, color, child) {
                      return Icon(
                        widget.buttonIcon,
                        size: MediaQuery.of(context).size.height * 0.026,
                        color: color,
                      );
                    },
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.025,
                    height: MediaQuery.of(context).size.width * 0.025,
                  ),
                  AnimatedDefaultTextStyle(
                    duration: Duration(milliseconds: 400),
                    curve: Curves.easeInOutCubic,
                    style: TextStyle(
                      fontFamily: 'InstrumentSans',
                      color: widget.textColor,
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      fontWeight: FontWeight.bold,
                    ),
                    child: Text(widget.buttonText),
                  ),
                ],
              ),
            ),
          )
        ],
      )
    );
  }
}

class ToggleButtonWidget extends StatefulWidget {

  final VoidCallback? toggleOnMethod;
  const ToggleButtonWidget({super.key, this.toggleOnMethod});

  @override
  State<ToggleButtonWidget> createState() => _ToggleButtonWidgetState();
}

class _ToggleButtonWidgetState extends State<ToggleButtonWidget> {

  bool toggled = false;

  void toggleToggled() {
    setState(() {
      toggled = !toggled;
    });

    if (widget.toggleOnMethod != null) {
      widget.toggleOnMethod!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleToggled,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOutCubic,
            width: MediaQuery.of(context).size.width * 0.08,
            height: MediaQuery.of(context).size.height * 0.02,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(90),
              color: toggled
                  ? const Color.fromRGBO(74, 184, 100, 1)
                  : const Color.fromRGBO(195, 195, 195, 1),
            ),
          ),
          AnimatedSlide(
            offset: Offset(toggled ? (MediaQuery.of(context).size.width * 0.0012) : -(MediaQuery.of(context).size.width * 0.0012), 0),
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOutCubic,
            child: Container(
              width: MediaQuery.of(context).size.height * 0.016,
              height: MediaQuery.of(context).size.height * 0.016,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(90)),
                  color: Colors.white
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MessageBox extends StatefulWidget {

  final VoidCallback? blurBackgroundMethod;
  const MessageBox({super.key, this.blurBackgroundMethod});

  @override
  State<MessageBox> createState() => _MessageBoxState();
}

class _MessageBoxState extends State<MessageBox> {

  bool showPrompts = false;

  void toggleShowPrompts() {
    setState(() {
      showPrompts = !showPrompts;
      widget.blurBackgroundMethod?.call();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedSlide(
          offset: Offset(0, showPrompts ? -5 : 0),
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOutCubic,
          child: PromptButton(
            promptText: "Regenerate Prompts",
            textColor: Color.fromRGBO(166, 173, 253, 1),
            textSize: MediaQuery.of(context).size.height * 0.015,
          ),
        ),
        AnimatedSlide(
          offset: Offset(0, showPrompts ? -3.6 : 0),
          duration: Duration(milliseconds: 400),
          curve: Curves.easeInOutCubic,
          child: PromptButton(
            promptText: "Find my BMI using my height and weight.",
            textColor: Color.fromRGBO(0, 0, 0, 1),
            textSize: MediaQuery.of(context).size.height * 0.015,
          ),
        ),
        AnimatedSlide(
          offset: Offset(0, showPrompts ? -1.3 : 0),
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOutCubic,
          child: PromptButton(
            promptText: "Can you make me a routine that focuses on chest and arms?",
            textColor: Color.fromRGBO(0, 0, 0, 1),
            textSize: MediaQuery.of(context).size.height * 0.015,
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.07,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.0, 1),
              end: Alignment(0.0, 0),
              colors: [
                Color.fromRGBO(166, 173, 253, 1),
                Color.fromRGBO(135, 230, 255, 1),
              ],
            ),
            borderRadius: const BorderRadius.all(Radius.circular(90)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 20,
                offset: const Offset(0, 10),
                spreadRadius: 1,
              ),
            ],
          ),
          child: Align(
            alignment: Alignment.center,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.87,
              height: MediaQuery.of(context).size.height * 0.057,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(90)),
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.01,
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                          color: Color.fromRGBO(60, 60, 60, 1),
                          fontFamily: 'InstrumentSans',
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.height * 0.017,
                        ),
                        decoration: InputDecoration(
                          hintText: "Send a message...",
                          hintStyle: TextStyle(
                            color: Color.fromRGBO(140, 140, 140, 1),
                            fontFamily: 'InstrumentSans',
                            fontWeight: FontWeight.bold,
                            fontSize:
                                MediaQuery.of(context).size.height * 0.017,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 18.0),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width * 0.015,
                      ),
                      child: GestureDetector(
                        onTap: toggleShowPrompts,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.09,
                          height: MediaQuery.of(context).size.width * 0.09,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment(0.0, 1),
                              end: Alignment(0.0, 0),
                              colors: [
                                Color.fromRGBO(166, 173, 253, 1),
                                Color.fromRGBO(135, 230, 255, 1),
                              ],
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(90),
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Image.asset(
                              'assets/icons/lightbulb.png',
                              scale: MediaQuery.of(context).size.width * 0.05,
                            ),
                          ),
                        ),
                      )
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PromptButton extends StatelessWidget {
  
  final String promptText;
  final Color textColor;
  final double textSize;

  const PromptButton({super.key, required this.promptText, required this.textColor, required this.textSize,});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.83,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.01, horizontal: MediaQuery.of(context).size.height * 0.02),
        child: Text(
          promptText,
          style: TextStyle(
            color: textColor,
            fontFamily: 'InstrumentSans',
            fontWeight: FontWeight.bold,
            fontSize: textSize,
          ),
        ),
      )
    );
  }
}

class LogoHeader extends StatelessWidget {

  final bool isDarkMode;

  const LogoHeader({super.key, required this.isDarkMode});

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
            "AI Advisor",
            style: TextStyle(
              fontFamily: 'InstrumentSans',
              color: isDarkMode ? Colors.white : Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}

class ConversationColumn extends StatelessWidget {
  final bool isDarkMode;

  const ConversationColumn({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.88,
      child: ListView.builder(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.15,
          bottom: 80,
        ),
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final msg = messages[index];

          bool showTimestampDivider = false;

          if (index == 0) {
            showTimestampDivider = true;
          } else {
            final prev = messages[index - 1];

            final prevDate = DateTime(prev.timestamp.year, prev.timestamp.month, prev.timestamp.day);
            final currDate = DateTime(msg.timestamp.year, msg.timestamp.month, msg.timestamp.day);

            if (prevDate != currDate) {
              showTimestampDivider = true;
            }
          }

          return Column(
            children: [
              if (showTimestampDivider)
                TimeStampDividerWidget(timestamp: msg.timestamp),

              TextMessageBubble(
                sent: msg.sent,
                messageContent: msg.content,
                isDarkMode: isDarkMode,
                timestamp: msg.timestamp,
              ),
            ],
          );
        },
      ),
    );
  }
}

class TimeStampDividerWidget extends StatelessWidget {

  final DateTime timestamp;

  const TimeStampDividerWidget({super.key, required this.timestamp});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * 0.07,
      child: Align(
        alignment: Alignment.center,
        child: Text(
          getTimeStampAsString(),
          style: TextStyle(
            fontFamily: 'InstrumentSans',
            color: Color.fromRGBO(75, 75, 75, 1),
            fontSize: MediaQuery.of(context).size.width * 0.036,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  String getTimeStampAsString() {

    final today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    final yesterday = today.subtract(Duration(days: 1));
    final dateToCheck = DateTime(timestamp.year, timestamp.month, timestamp.day);

    if (dateToCheck == today) {
      return "Today";
    }

    if (dateToCheck == yesterday) {
      return "Yesterday";
    }

    int day = timestamp.day;
    int month = timestamp.month;
    int year = timestamp.year;

    String date = month.toString() + "/" + day.toString() + "/" + year.toString();

    return date;
  }
}

class TextMessageBubble extends StatelessWidget {

  final bool sent;
  final bool isDarkMode;

  final DateTime timestamp;

  final String messageContent;

  const TextMessageBubble({super.key, required this.sent, required this.messageContent, required this.isDarkMode, required this.timestamp});

  @override
  Widget build(BuildContext context) {
    final maxBubbleWidth = MediaQuery.of(context).size.width * 0.7;

    return GestureDetector(
      child: Row(
        mainAxisAlignment: sent ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: sent ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.005,
                  left: MediaQuery.of(context).size.width * 0.035,
                  right: MediaQuery.of(context).size.width * 0.035,
                ),
                child: Text(
                  sent ? "You" : "AI Advisor",
                  style: TextStyle(
                    fontFamily: 'InstrumentSans',
                    color: isDarkMode ? Colors.white : Color.fromRGBO(140, 140, 140, 1),
                    fontSize: MediaQuery.of(context).size.width * 0.034,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                constraints: BoxConstraints(
                  maxWidth: maxBubbleWidth,
                ),
                decoration: BoxDecoration(
                  color: sent
                      ? isDarkMode ? Color.fromRGBO(115, 147, 209, 1) : Color.fromRGBO(196, 230, 255, 1)
                      : isDarkMode ? Color.fromRGBO(77, 77, 77, 1) : Color.fromRGBO(237, 237, 237, 1),
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(14),
                    topRight: const Radius.circular(14),
                    bottomRight:
                    sent ? const Radius.circular(0) : const Radius.circular(14),
                    bottomLeft:
                    sent ? const Radius.circular(14) : const Radius.circular(0),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.015,
                    horizontal: MediaQuery.of(context).size.width * 0.04,
                  ),
                  child: Text(
                    messageContent,
                    style: TextStyle(
                      fontFamily: 'InstrumentSans',
                      color: isDarkMode ? Colors.white : Color.fromRGBO(65, 65, 65, 1),
                      fontSize: MediaQuery.of(context).size.width * 0.034,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.04,
                width: MediaQuery.of(context).size.width * 0.04,
              ),
            ],
          ),
        ],
      ),
    );
  }
}