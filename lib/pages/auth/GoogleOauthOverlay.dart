import 'dart:ui';
import 'package:flutter/material.dart';

class GoogleOauthOverlay extends StatefulWidget {

  final bool active;

  const GoogleOauthOverlay({super.key, required this.active});

  @override
  State<GoogleOauthOverlay> createState() => GoogleOauthOverlayState();
}

class GoogleOauthOverlayState extends State<GoogleOauthOverlay> {

  int formPage = 0;
  int maxPage = 1;

    final GlobalKey<_GoogleInputFieldWidgetState> emailFieldKey = GlobalKey();
  final GlobalKey<_GoogleInputFieldWidgetState> passwordFieldKey = GlobalKey();

  void navigateFormTo(int page) {
    setState(() {
      formPage = page;
    });
  }

  void progressForm() {
    if (formPage < maxPage) {
      setState(() {
        formPage++;
      });
    }
  }

  void resetForm() {
    emailFieldKey.currentState?.clearText();
    emailFieldKey.currentState?.resetInputState();
    passwordFieldKey.currentState?.clearText();
    passwordFieldKey.currentState?.resetInputState();
    setState(() {
      formPage = 0;
    });
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
                      offset: Offset(MediaQuery.of(context).size.width * formSlide(0), 0),
                      curve: Curves.easeInOutCubic,
                      duration: const Duration(milliseconds: 500),
                      child: EmailFormPage(emailKey: emailFieldKey),
                    ),
                    AnimatedSlide(
                      offset: Offset(MediaQuery.of(context).size.width * formSlide(1), 0),
                      curve: Curves.easeInOutCubic,
                      duration: const Duration(milliseconds: 500),
                      child: PasswordFormPage(passwordKey: passwordFieldKey),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.67,
                        top: MediaQuery.of(context).size.height * 0.39,
                      ),
                      child: NextButtonWidget(
                        progressViewMethod: () {
                          final valid = emailFieldKey.currentState?.validateEmail() ?? false;
                          if (valid) {
                            progressForm();
                          }
                        },
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

  double formSlide(int pageNumber) {

    if (pageNumber == 0) {
      if (formPage == 0) {
        return 0;
      } else if (formPage >= 1) {
        return -0.003;
      }
    } else if (pageNumber == 1) {
      if (formPage == 0) {
        return 0.003;
      } else if (formPage == 1) {
        return 0;
      } else if (formPage >= 1) {
        return -0.003;
      }
    }

    return 0;
  }
}

class PasswordFormPage extends StatefulWidget {

  final GlobalKey<_GoogleInputFieldWidgetState> passwordKey;

  const PasswordFormPage({super.key, required this.passwordKey});

  @override
  State<PasswordFormPage> createState() => _PasswordFormPageState();
}

class _PasswordFormPageState extends State<PasswordFormPage> {

  bool validPasswordInput = true;
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
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
              invalidInputText: "Wrong password. Try again or click Forgot Password.",
              obscureText: true,
              controller: passwordController,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.025,),
            SizedBox(height: MediaQuery.of(context).size.height * 0.118,),
            Container(
              width: MediaQuery.of(context).size.width * 0.86,
              height: MediaQuery.of(context).size.height * 0.03,
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
        ),
        Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.24),
          child: AnimatedSlide(
            offset: Offset(0, 0),
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOutCubic,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.91,
              height: MediaQuery.of(context).size.height * 0.037,
              child: PasswordToggleWidget(),
            ),
          )
        )
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

  bool validEmailInput = true;

  final TextEditingController emailController = TextEditingController();

  bool checkIfValidEmail(String string) {

    final emailText = emailController.text.trim();

    if (emailText.isNotEmpty) {
      if (emailText.contains("@") && emailText.contains(".")) {
        return true;
      }
    }
    return false;
  }

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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "to continue to",
              style: TextStyle(
                fontFamily: 'Roboto',
                color: Colors.black,
                fontSize: MediaQuery.of(context).size.width * 0.042,
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.012,),
            Text(
              "GymAdvisor",
              style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(26, 115, 232, 1.0),
                fontSize: MediaQuery.of(context).size.width * 0.042,
              ),
            ),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.0325),
        GoogleInputFieldWidget(
          inputHeader: "Email or phone",
          invalidInputText: "Enter a valid email or phone number",
          obscureText: false,
          key: widget.emailKey,
          controller: emailController,
        ),
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
  final String invalidInputText;
  final bool obscureText;

  final TextEditingController controller;

  const GoogleInputFieldWidget({super.key, required this.inputHeader, required this.obscureText, required this.invalidInputText, required this.controller});

  @override
  State<GoogleInputFieldWidget> createState() => _GoogleInputFieldWidgetState();
}

class _GoogleInputFieldWidgetState extends State<GoogleInputFieldWidget> {

  bool headerActivated = false;
  late TextEditingController _controller;
  late FocusNode _focusNode;
  late bool _invalidInput = false;

  String getText() => _controller.text;

  bool validateEmail() {
    if (_controller.text.trim().isEmpty) {
      setState(() {
        _invalidInput = true;
      });
      return false;
    } else {
      if (matchesEmailRegex(_controller.text)) {
        setState(() {
          _invalidInput = false;
        });
        return true;
      } else if (matchesPhoneRegex(_controller.text)) {
        setState(() {
          _invalidInput = false;
        });
        return true;
      } else {
        setState(() {
          _invalidInput = true;
        });
        return false;
      }
    }
  }

  bool matchesPhoneRegex(String text) {

    final phoneRegex = RegExp(r'^\+?[0-9]{7,15}$');

    return phoneRegex.hasMatch(text);
  }

  bool matchesEmailRegex(String text) {

    final emailRegex = RegExp(r"^[\w\.\+\-]+@[a-zA-Z0-9\-]+\.[a-zA-Z]{2,}$");

    return emailRegex.hasMatch(text);
  }

  void resetInputState() {
    setState(() {
      _invalidInput = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
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
        if (widget.controller!.text.isEmpty) {
          setState(() => headerActivated = false);
        }
      }
    });
  }

  @override
  void dispose() {
    widget.controller.dispose();
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
      height: MediaQuery.of(context).size.height * 0.11,
      child: Column(
        children: [
          Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 8),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.86,
                  height: MediaQuery.of(context).size.height * 0.05742,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: currentColor(),
                      width: headerActivated ? 2 : 1.5,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                  ),
                  child: TextField(
                    controller: widget.controller,
                    focusNode: _focusNode,
                    obscureText: widget.obscureText,
                    cursorColor: Color.fromRGBO(26, 115, 232, 1),
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Roboto',
                      fontSize: widget.obscureText ? MediaQuery.of(context).size.height * 0.025 : MediaQuery.of(context).size.height * 0.017,
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
                      duration: const Duration(milliseconds: 200),
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
                                    color: currentColor(),
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
          AnimatedOpacity(
            opacity: _invalidInput ? 1 : 0,
            duration: Duration(milliseconds: 200),
            curve: Curves.easeInOutCubic,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.91,
              height: MediaQuery.of(context).size.height * 0.035,
              child: Row(
                children: [
                  Icon(Icons.error, color: Color.fromRGBO(255, 126, 117, 1), size: 16,),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.021,),
                  Text(
                    widget.invalidInputText,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: Color.fromRGBO(255, 126, 117, 1),
                      fontSize: MediaQuery.of(context).size.width * 0.032,
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

  Color currentColor() {

    if (_invalidInput) {
      return Color.fromRGBO(255, 126, 117, 1);
    } else {
      if (headerActivated) {
        return Color.fromRGBO(26, 115, 232, 1.0);
      }
    }

    return Color.fromRGBO(150, 150, 150, 1.0);
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
