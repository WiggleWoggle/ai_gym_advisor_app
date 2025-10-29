import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppleAuthOverlay extends StatefulWidget {
  final bool active;

  const AppleAuthOverlay({super.key, required this.active});

  @override
  State<AppleAuthOverlay> createState() => AppleAuthOverlayState();
}

class AppleAuthOverlayState extends State<AppleAuthOverlay> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 1.0,
      width: MediaQuery.of(context).size.width * 1.0,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: AnimatedSlide(
          offset: Offset(0, widget.active ? 0 : 1),
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOutCubic,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.57,
            width: MediaQuery.of(context).size.width * 1.0,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(242, 242, 247, 1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.84,
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.87,
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Sign in with Apple",
                          style: TextStyle(
                            fontFamily: 'SF_Bold',
                            color: Colors.black,
                            fontSize: MediaQuery.of(context).size.width * 0.045,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.08,
                          height: MediaQuery.of(context).size.width * 0.08,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Color.fromRGBO(229, 229, 234, 1)
                          ),
                          child: Icon(Icons.close, size: 22, color: Color.fromRGBO(140, 140, 144, 1),),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.84,
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    "assets/icons/appLogo.png",
                    scale: 5,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.84,
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.84,
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: Text(
                    "Create an account for GymAdvisor using your Apple Account.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'SF_Regular',
                      color: Colors.black,
                      fontSize: MediaQuery.of(context).size.width * 0.035,
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.84,
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                SignInChoice(
                  topRounding: 12,
                  bottomRounding: 12,
                  title: "Name",
                  subTitle: "John Doe",
                  icon: Icon(CupertinoIcons.person_solid),
                  showIcon: true,
                  checkBox: false,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.84,
                  height: MediaQuery.of(context).size.height * 0.013,
                ),
                SignInChoice(
                  topRounding: 12,
                  bottomRounding: 0,
                  title: "Share My Email",
                  subTitle: "johndoe@icloud.com",
                  icon: Icon(CupertinoIcons.mail_solid),
                  showIcon: true,
                  checkBox: true,
                ),
                SignInChoice(
                  topRounding: 0,
                  bottomRounding: 12,
                  title: "Hide My Email",
                  subTitle: "Forward To: johndoe@icloud.com",
                  icon: Icon(CupertinoIcons.person_solid),
                  showIcon: false,
                  checkBox: true,
                ),
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
                  child: iosContinue(),
                )
              ],
            )
          ),
        ),
      ),
    );
  }
}

class SignInChoice extends StatefulWidget {

  final double topRounding;
  final double bottomRounding;
  final String title;
  final String subTitle;
  final Icon icon;
  final bool showIcon;
  final bool checkBox;

  const SignInChoice({super.key, required this.topRounding, required this.bottomRounding, required this.title, required this.subTitle, required this.icon, required this.showIcon, required this.checkBox});

  @override
  State<SignInChoice> createState() => _SignInChoiceState();
}

class _SignInChoiceState extends State<SignInChoice> {

  late bool isChecked = true;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.89,
        height: MediaQuery.of(context).size.height * 0.073,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topRight: Radius.circular(widget.topRounding), topLeft: Radius.circular(widget.topRounding), bottomLeft: Radius.circular(widget.bottomRounding), bottomRight: Radius.circular(widget.bottomRounding)),
            color: Colors.white
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.width * 0.13,
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.11,
                      height: MediaQuery.of(context).size.width * 0.09,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: widget.showIcon ? Color.fromRGBO(242, 242, 247, 1) : Colors.white,
                      ),
                      child: widget.showIcon ? widget.icon : null,
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.045),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.54,
                          height: MediaQuery.of(context).size.width * 0.1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.title,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'SF_Regular',
                                  color: Colors.black,
                                  fontSize: MediaQuery.of(context).size.width * 0.035,
                                ),
                              ),
                              Text(
                                widget.subTitle,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'SF_Regular',
                                  color: Color.fromRGBO(113, 113, 117, 1),
                                  fontSize: MediaQuery.of(context).size.width * 0.027,
                                ),
                              ),
                            ],
                          ),
                        )
                    )
                  ],
                ),
              ),
              if (!widget.checkBox)
                Container(
                  width: MediaQuery.of(context).size.width * 0.06,
                  height: MediaQuery.of(context).size.width * 0.06,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Color.fromRGBO(229, 229, 234, 1)
                  ),
                  child: Icon(Icons.close, size: 16, color: Color.fromRGBO(140, 140, 144, 1),),
                ),
              if (widget.checkBox)
                iosCheckbox(
                  checked: false,
                )
            ],
          ),
        )
    );
  }
}

class iosCheckbox extends StatefulWidget {

  final bool checked;

  const iosCheckbox({super.key, required this.checked});

  @override
  State<iosCheckbox> createState() => _iosCheckboxState();
}

class _iosCheckboxState extends State<iosCheckbox> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.058,
      height: MediaQuery.of(context).size.width * 0.058,
      decoration: BoxDecoration(
        color: widget.checked ? Color.fromRGBO(0, 122, 255, 1) : Colors.transparent,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          color: widget.checked ? Colors.transparent : Color.fromRGBO(181, 181, 184, 1),
          width: widget.checked ? 0 : 2.0,
        ),
      ),
      child: Icon(Icons.check_rounded, color: Colors.white, size: 16,),
    );
  }
}

class iosContinue extends StatefulWidget {

  const iosContinue({super.key});

  @override
  State<iosContinue> createState() => _iosContinueState();
}

class _iosContinueState extends State<iosContinue> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.29,
      height: MediaQuery.of(context).size.width * 0.11,
      decoration: BoxDecoration(
        color: Color.fromRGBO(0, 122, 255, 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          "Continue",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'SF_Medium',
            color: Colors.white,
            fontSize: MediaQuery.of(context).size.width * 0.035,
          ),
        ),
      )
    );
  }
}