import 'dart:ui';

import 'package:flutter/material.dart';

class GoogleOauthOverlay extends StatefulWidget {
  final bool active;

  const GoogleOauthOverlay({super.key, required this.active});

  @override
  State<GoogleOauthOverlay> createState() => GoogleOauthOverlayState();
}

class GoogleOauthOverlayState extends State<GoogleOauthOverlay> {

  bool passwordForm = false;

  final GlobalKey<_GoogleInputFieldWidgetState> emailFieldKey = GlobalKey();
  final GlobalKey<_GoogleInputFieldWidgetState> passwordFieldKey = GlobalKey();

  void togglePasswordForm() {
    setState(() {
      passwordForm = !passwordForm;
    });
  }

  void resetForm() {
    emailFieldKey.currentState?.clearText();
    passwordFieldKey.currentState?.clearText();
    passwordForm = false;
  }

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
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Image.asset('assets/icons/googleBanner.png', scale: 38),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    AnimatedSlide(
                      offset: Offset(passwordForm ? MediaQuery.of(context).size.width * -0.003 : 0, 0),
                      curve: Curves.easeInOutCubic,
                      duration: const Duration(milliseconds: 500),
                      child: EmailFormPage(emailKey: emailFieldKey),
                    ),
                    AnimatedSlide(
                      offset: Offset(passwordForm ? 0 : MediaQuery.of(context).size.width * 0.003, 0),
                      curve: Curves.easeInOutCubic,
                      duration: const Duration(milliseconds: 500),
                      child: PasswordFormPage(passwordKey: passwordFieldKey),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.67,
                        top: MediaQuery.of(context).size.height * 0.375,
                      ),
                      child: NextButtonWidget(
                        progressViewMethod: togglePasswordForm,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PasswordFormPage extends StatefulWidget {

  final GlobalKey<_GoogleInputFieldWidgetState> passwordKey;

  const PasswordFormPage({super.key, required this.passwordKey});

  @override
  State<PasswordFormPage> createState() => _PasswordFormPageState();
}

class _PasswordFormPageState extends State<PasswordFormPage> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        Container(
          width: MediaQuery.of(context).size.width * 0.91,
          height: MediaQuery.of(context).size.height * 0.08,
          child: Column(
            children: [
              Text(
                "Hi User",
                style: TextStyle(
                  fontFamily: 'Roboto',
                  color: Colors.black,
                  fontSize: MediaQuery.of(context).size.width * 0.055,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.013),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(
                      "assets/icons/defaultUser.png",
                      scale: 20,
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.025,),
                  Text(
                    "johndoe@gmail.com",
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: Colors.black,
                      fontSize: MediaQuery.of(context).size.width * 0.034,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.035),
        GoogleInputFieldWidget(
          key: widget.passwordKey,
          inputHeader: "Enter your password",
          obscureText: true,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.91,
          height: 40,
          child: PasswordToggleWidget(),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.118,),
        Container(
          width: MediaQuery.of(context).size.width * 0.86,
          height: MediaQuery.of(context).size.height * 0.04333,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Forgot password?",
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(26, 115, 232, 1.0),
                  fontSize: MediaQuery.of(context).size.width * 0.034,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class EmailFormPage extends StatefulWidget {

  final GlobalKey<_GoogleInputFieldWidgetState> emailKey;

  const EmailFormPage({super.key, required this.emailKey});

  @override
  State<EmailFormPage> createState() => _EmailFormPageState();
}

class _EmailFormPageState extends State<EmailFormPage> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.025),
        Text(
          "Sign in",
          style: TextStyle(
            fontFamily: 'Roboto',
            color: Colors.black,
            fontSize: MediaQuery.of(context).size.width * 0.055,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.00867),
        Text(
          "with your Google Account",
          style: TextStyle(
            fontFamily: 'Roboto',
            color: Colors.black,
            fontSize: MediaQuery.of(context).size.width * 0.042,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.0325),
        GoogleInputFieldWidget(
          inputHeader: "Email or phone",
          obscureText: false,
          key: widget.emailKey,
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01083),
        Container(
          width: MediaQuery.of(context).size.width * 0.86,
          height: MediaQuery.of(context).size.height * 0.04333,
          child: Text(
            "Forgot email?",
            style: TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(26, 115, 232, 1.0),
              fontSize: MediaQuery.of(context).size.width * 0.033,
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01083),
        Container(
          width: MediaQuery.of(context).size.width * 0.86,
          height: MediaQuery.of(context).size.height * 0.02708,
          child: Text(
            "Not your device? Use Guest mode to sign in privately.",
            style: TextStyle(
              fontFamily: 'Roboto',
              color: Color.fromRGBO(95, 99, 104, 1.0),
              fontSize: MediaQuery.of(context).size.width * 0.033,
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.86,
          height: MediaQuery.of(context).size.height * 0.0325,
          child: Text(
            "Learn more",
            style: TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(26, 115, 232, 1.0),
              fontSize: MediaQuery.of(context).size.width * 0.033,
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.03792),
        Container(
          width: MediaQuery.of(context).size.width * 0.86,
          height: MediaQuery.of(context).size.height * 0.04333,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Create account",
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(26, 115, 232, 1.0),
                  fontSize: MediaQuery.of(context).size.width * 0.034,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class PasswordToggleWidget extends StatefulWidget {

  const PasswordToggleWidget({super.key});

  @override
  State<PasswordToggleWidget> createState() => _PasswordToggleWidgetState();
}

class _PasswordToggleWidgetState extends State<PasswordToggleWidget> {

  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Theme(
          data: Theme.of(context).copyWith(
            checkboxTheme: CheckboxThemeData(
              overlayColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                  return Colors.transparent;
                },
              ),
            ),
          ),
          child: Checkbox(
            value: showPassword,
            onChanged: (bool? value) {
              setState(() {
                showPassword = value!;
              });
            },
            activeColor: const Color.fromRGBO(26, 115, 232, 1),
            checkColor: Colors.white,
          ),
        ),
        Text(
          "Show password",
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Roboto',
            fontSize: MediaQuery.of(context).size.height * 0.016,
          ),
        ),
      ],
    );
  }
}

class GoogleInputFieldWidget extends StatefulWidget {

  final String inputHeader;
  final bool obscureText;

  const GoogleInputFieldWidget({super.key, required this.inputHeader, required this.obscureText});

  @override
  State<GoogleInputFieldWidget> createState() => _GoogleInputFieldWidgetState();
}

class _GoogleInputFieldWidgetState extends State<GoogleInputFieldWidget> {

  bool headerActivated = false;
  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();

    _controller.addListener(() {
      final hasText = _controller.text.isNotEmpty;
      if (hasText && !headerActivated) {
        setState(() => headerActivated = true);
      } else if (!hasText && !_focusNode.hasFocus && headerActivated) {
        setState(() => headerActivated = false);
      }
    });

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() => headerActivated = true);
      } else {
        if (_controller.text.isEmpty) {
          setState(() => headerActivated = false);
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void clearText() {
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.86,
      height: MediaQuery.of(context).size.height * 0.07583,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 8),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.86,
              height: MediaQuery.of(context).size.height * 0.05742,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Color.fromRGBO(26, 115, 232, 1.0),
                  width: 2,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(4)),
              ),
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                obscureText: widget.obscureText,
                cursorColor: Colors.black,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Roboto',
                  fontSize: MediaQuery.of(context).size.height * 0.017,
                ),
                decoration: InputDecoration(
                  hintText: "",
                  hintStyle: TextStyle(
                    color: Color.fromRGBO(105, 93, 93, 1),
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.height * 0.017,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 18.0),
                ),
              ),
            ),
          ),
          IgnorePointer(
            ignoring: true,
            child: Padding(
              padding: const EdgeInsets.only(left: 14, bottom: 20),
              child: AnimatedSlide(
                offset: Offset(0, headerActivated ? -0.1 : MediaQuery.of(context).size.height * 0.001),
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOutCubic,
                child: Stack(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Text(
                            widget.inputHeader,
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              color: const Color.fromRGBO(26, 115, 232, 1.0),
                              fontSize: MediaQuery.of(context).size.width * 0.032,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ),
            ),
          )
        ],
      ),
    );
  }
}

class NextButtonWidget extends StatefulWidget {
  final VoidCallback? progressViewMethod;

  NextButtonWidget({Key? key, this.progressViewMethod}) : super(key: key);

  @override
  State<NextButtonWidget> createState() => _NextButtonWidgetState();
}

class _NextButtonWidgetState extends State<NextButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.progressViewMethod,
      child: Text(
        "Next",
        style: TextStyle(
          fontFamily: 'Roboto',
          color: Colors.white,
          fontSize: MediaQuery.of(context).size.width * 0.034,
        ),
      ),
      style: TextButton.styleFrom(
        backgroundColor: Color.fromRGBO(26, 115, 232, 1),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
    );
  }
}
