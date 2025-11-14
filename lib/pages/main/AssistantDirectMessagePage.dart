import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AssistantDirectMessagePage extends StatefulWidget {
  const AssistantDirectMessagePage({super.key});

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
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(0.0, 1.7),
                end: Alignment(0.0, 0.2),
                colors: [Color.fromRGBO(166, 173, 253, 0.2), Colors.white],
              ),
            ),
            child: Stack(
              children: [
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
              color: Colors.white,
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
                    color: Color.fromRGBO(75, 75, 75, 1),
                  ),
                )
              ),
            )
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
                padding: EdgeInsets.only(top: 70),
                child: LogoHeader()
            ),
          ),
          IgnorePointer(
            child: AnimatedOpacity(
              opacity: settingsPage ? 1 : 0,
              duration: Duration(milliseconds: 600),
              curve: Curves.easeInOutCubic,
              child: Container(
                color: Color.fromRGBO(217, 217, 217, 0.7),
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
  const AdvisorSettingsWidget({super.key, this.toggleSettingsPage});

  @override
  State<AdvisorSettingsWidget> createState() => _AdvisorSettingsWidgetState();
}

class _AdvisorSettingsWidgetState extends State<AdvisorSettingsWidget> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.92,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.0, 1),
          end: Alignment(0.0, 0),
          colors: [
            Color.fromRGBO(234, 236, 251, 1),
            Colors.white,
          ],
        ),
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(45),
          topRight: const Radius.circular(45),
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ChatLanguageSettingsPage()
          /*
          SettingsLandingPage(
            toggleSettingsPage: widget.toggleSettingsPage,
          )
           */
        ],
      )
    );
  }
}

class ChatLanguageSettingsPage extends StatefulWidget {

  const ChatLanguageSettingsPage({super.key});

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
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Icon(Icons.arrow_back_ios_rounded, size: 22, color: Color.fromRGBO(140, 140, 144, 1),)
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
                        color: const Color.fromRGBO(75, 75, 75, 1),
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
                  ),
                  SelectableSettingsOptionWidget(
                    optionText: "Spanish",
                    id: 1,
                    selectedID: selectedID,
                    updateSelectedID: updateSelectedID,
                  ),
                  SelectableSettingsOptionWidget(
                    optionText: "French",
                    id: 2,
                    selectedID: selectedID,
                    updateSelectedID: updateSelectedID,
                  ),
                  SelectableSettingsOptionWidget(
                    optionText: "Chinese",
                    id: 3,
                    selectedID: selectedID,
                    updateSelectedID: updateSelectedID,
                  ),
                  SelectableSettingsOptionWidget(
                    optionText: "Japanese",
                    id: 4,
                    selectedID: selectedID,
                    updateSelectedID: updateSelectedID,
                  ),
                  SelectableSettingsOptionWidget(
                    optionText: "Vietnamese",
                    id: 5,
                    selectedID: selectedID,
                    updateSelectedID: updateSelectedID,
                  ),
                  SelectableSettingsOptionWidget(
                    optionText: "German",
                    id: 6,
                    selectedID: selectedID,
                    updateSelectedID: updateSelectedID,
                  ),
                  SelectableSettingsOptionWidget(
                    optionText: "Arabic",
                    id: 7,
                    selectedID: selectedID,
                    updateSelectedID: updateSelectedID,
                  ),
                  SelectableSettingsOptionWidget(
                    optionText: "Taiwanese",
                    id: 8,
                    selectedID: selectedID,
                    updateSelectedID: updateSelectedID,
                  ),
                  SelectableSettingsOptionWidget(
                    optionText: "Korean",
                    id: 9,
                    selectedID: selectedID,
                    updateSelectedID: updateSelectedID,
                  ),
                  SelectableSettingsOptionWidget(
                    optionText: "Portuguese",
                    id: 10,
                    selectedID: selectedID,
                    updateSelectedID: updateSelectedID,
                  ),
                  SelectableSettingsOptionWidget(
                    optionText: "Italian",
                    id: 11,
                    selectedID: selectedID,
                    updateSelectedID: updateSelectedID,
                  ),
                  SelectableSettingsOptionWidget(
                    optionText: "Russian",
                    id: 12,
                    selectedID: selectedID,
                    updateSelectedID: updateSelectedID,
                  ),
                  SelectableSettingsOptionWidget(
                    optionText: "Hindi",
                    id: 13,
                    selectedID: selectedID,
                    updateSelectedID: updateSelectedID,
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
  const SettingsLandingPage({super.key, this.toggleSettingsPage});

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
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.08,
                          height: MediaQuery.of(context).size.width * 0.08,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Color.fromRGBO(229, 229, 234, 1)
                          ),
                          child: Icon(Icons.close, size: 22, color: Color.fromRGBO(140, 140, 144, 1),),
                        ),
                      )
                  )
              ),
              Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: MediaQuery.of(context).size.height * 0.04,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "AI Advisor Settings",
                      style: TextStyle(
                        fontFamily: 'InstrumentSans',
                        color: const Color.fromRGBO(75, 75, 75, 1),
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
          height: MediaQuery.of(context).size.width * 0.05,
        ),
        Container(
            width: MediaQuery.of(context).size.width * 0.84,
            height: MediaQuery.of(context).size.height * 0.05,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Chat Info",
                style: TextStyle(
                  fontFamily: 'InstrumentSans',
                  color: Color.fromRGBO(64, 64, 64, 1),
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
        ),
        InfoWidget(),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.08,
          height: MediaQuery.of(context).size.width * 0.08,
        ),
        Container(
            width: MediaQuery.of(context).size.width * 0.84,
            height: MediaQuery.of(context).size.height * 0.05,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Chat Settings",
                style: TextStyle(
                  fontFamily: 'InstrumentSans',
                  color: Color.fromRGBO(64, 64, 64, 1),
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
        ),
        SettingsOptionButton(
          buttonIcon: CupertinoIcons.globe,
          buttonText: "Chat Language",
          hasSubMenu: true,
          hasSubMenuText: true,
          subMenuText: "English",
          hasToggleButton: false,
          textColor: Color.fromRGBO(64, 64, 64, 1),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.04,
          height: MediaQuery.of(context).size.width * 0.04,
        ),
        SettingsOptionButton(
          buttonIcon: CupertinoIcons.archivebox,
          buttonText: "Archived Chats",
          hasSubMenu: true,
          hasSubMenuText: false,
          subMenuText: "English",
          hasToggleButton: false,
          textColor: Color.fromRGBO(64, 64, 64, 1),
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
          textColor: Color.fromRGBO(64, 64, 64, 1),
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
              child: Text(
                "Privacy",
                style: TextStyle(
                  fontFamily: 'InstrumentSans',
                  color: Color.fromRGBO(64, 64, 64, 1),
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                  fontWeight: FontWeight.bold,
                ),
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
          textColor: Color.fromRGBO(64, 64, 64, 1),
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
        ),
      ],
    );
  }
}

class SelectableSettingsOptionWidget extends StatefulWidget {

  final int id;
  final int selectedID;
  final String optionText;
  final Function(int)? updateSelectedID;
  const SelectableSettingsOptionWidget({super.key, required this.optionText, required this.id, required this.selectedID, this.updateSelectedID});

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
                      color: selected() ? Color.fromRGBO(166, 173, 253, 1) : Colors.white,
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
                                color: Color.fromRGBO(64, 64, 64, 1),
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

  const InfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.87,
        height: MediaQuery.of(context).size.height * 0.14,
        decoration: BoxDecoration(
          color: Colors.white,
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
                    Icon(
                      Icons.info_outline_rounded,
                      size: MediaQuery.of(context).size.height * 0.025,
                      color: Color.fromRGBO(64, 64, 64, 1),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.025,
                      height: MediaQuery.of(context).size.width * 0.025,
                    ),
                    Text(
                      "107 chats sent",
                      style: TextStyle(
                        fontFamily: 'InstrumentSans',
                        color: Color.fromRGBO(64, 64, 64, 1),
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                        fontWeight: FontWeight.bold,
                      ),
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
                    Icon(
                      Icons.thumb_up_alt_outlined,
                      size: MediaQuery.of(context).size.height * 0.025,
                      color: Color.fromRGBO(64, 64, 64, 1),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.025,
                      height: MediaQuery.of(context).size.width * 0.025,
                    ),
                    Text(
                      "81 chats marked supported",
                      style: TextStyle(
                        fontFamily: 'InstrumentSans',
                        color: Color.fromRGBO(64, 64, 64, 1),
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                        fontWeight: FontWeight.bold,
                      ),
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
                    Icon(
                      Icons.thumb_down_off_alt_rounded,
                      size: MediaQuery.of(context).size.height * 0.025,
                      color: Color.fromRGBO(64, 64, 64, 1),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.025,
                      height: MediaQuery.of(context).size.width * 0.025,
                    ),
                    Text(
                      "26 chats marked unsupported",
                      style: TextStyle(
                        fontFamily: 'InstrumentSans',
                        color: Color.fromRGBO(64, 64, 64, 1),
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                        fontWeight: FontWeight.bold,
                      ),
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

  final bool hasSubMenu;
  final bool hasSubMenuText;
  final String subMenuText;

  final bool hasToggleButton;

  const SettingsOptionButton({super.key, required this.buttonIcon, required this.buttonText, required this.hasSubMenu, required this.hasSubMenuText, required this.subMenuText, required this.textColor, required this.hasToggleButton});

  @override
  State<SettingsOptionButton> createState() => _SettingsOptionButtonState();
}

class _SettingsOptionButtonState extends State<SettingsOptionButton> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.87,
      height: MediaQuery.of(context).size.height * 0.053,
      decoration: BoxDecoration(
        color: Colors.white,
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
                    ToggleButtonWidget()
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
                  Icon(
                    widget.buttonIcon,
                    size: MediaQuery.of(context).size.height * 0.026,
                    color: widget.textColor,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.025,
                    height: MediaQuery.of(context).size.width * 0.025,
                  ),
                  Text(
                    widget.buttonText,
                    style: TextStyle(
                      fontFamily: 'InstrumentSans',
                      color: widget.textColor,
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      fontWeight: FontWeight.bold,
                    ),
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

  const ToggleButtonWidget({super.key});

  @override
  State<ToggleButtonWidget> createState() => _ToggleButtonWidgetState();
}

class _ToggleButtonWidgetState extends State<ToggleButtonWidget> {

  bool toggled = false;

  void toggleToggled() {
    setState(() {
      toggled = !toggled;
    });
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
            "AI Advisor",
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

class TextMessageBubble extends StatelessWidget {

  final bool sent;
  final String messageContent;

  const TextMessageBubble({super.key, required this.sent, required this.messageContent});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
      sent ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            right: MediaQuery.of(context).size.width * 0.02,
            bottom: MediaQuery.of(context).size.height * 0.005,
          ),
          child: Text(
            sent ? "You" : "AI Advisor",
            style: TextStyle(
              fontFamily: 'InstrumentSans',
              color: const Color.fromRGBO(140, 140, 140, 1),
              fontSize: MediaQuery.of(context).size.width * 0.034,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.6,
          decoration: BoxDecoration(
            color: sent
                ? const Color.fromRGBO(196, 230, 255, 1)
                : const Color.fromRGBO(237, 237, 237, 1),
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
                color: const Color.fromRGBO(65, 65, 65, 1),
                fontSize: MediaQuery.of(context).size.width * 0.034,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}