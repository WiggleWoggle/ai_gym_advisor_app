import 'package:ai_gym_advisor_app/pages/auth/GoogleOauthOverlay.dart';
import 'package:flutter/material.dart';

class SignInFormPage extends StatefulWidget {

  final ValueChanged<bool> updateFormCompletion;

  const SignInFormPage({super.key, required this.updateFormCompletion});

  @override
  State<SignInFormPage> createState() => _SignInFormPageState();
}

class _SignInFormPageState extends State<SignInFormPage> {

  bool loginView = true;
  bool googleOverlay = false;
  final GlobalKey<GoogleOauthOverlayState> _googleOverlayKey = GlobalKey();

  void switchOverlay() {
    setState(() {
      googleOverlay = !googleOverlay;
    });
  }

  void switchView() {
    setState(() {
      loginView = !loginView;
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
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 90,),
                Image.asset(
                  'assets/icons/logo.png',
                  scale: 1.7,
                ),
                SizedBox(height: 20,),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    AnimatedSlide(
                        offset: Offset(0, loginView ? 0 : 1),
                        duration: Duration(milliseconds: 400),
                        curve: Curves.easeInOutCubic,
                        child: AnimatedOpacity(
                          opacity: loginView ? 1 : 0,
                          duration: Duration(milliseconds: 400),
                          curve: Curves.easeInOutCubic,
                          child: Text(
                            "Welcome back.",
                            style: const TextStyle(
                              fontFamily: 'InstrumentSans',
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                    ),
                    AnimatedSlide(
                        offset: Offset(0, loginView ? 1 : 0),
                        duration: Duration(milliseconds: 400),
                        curve: Curves.easeInOutCubic,
                        child: AnimatedOpacity(
                          opacity: loginView ? 0 : 1,
                          duration: Duration(milliseconds: 400),
                          curve: Curves.easeInOutCubic,
                          child: Text(
                            "Welcome to GymAdvisor.",
                            style: const TextStyle(
                              fontFamily: 'InstrumentSans',
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                    ),
                  ],
                ),
                SizedBox(height: 50,),
                AnimatedSwitcher(
                  switchInCurve: Curves.easeInOutCubic,
                  switchOutCurve: Curves.easeInOutCubic,
                  duration: Duration(milliseconds: 600),
                  transitionBuilder: (child, animation) {
                    final isLogin = child.key == const ValueKey('loginForm');

                    final offsetAnimation = Tween<Offset>(
                      begin: isLogin
                          ? const Offset(-1.0, 0.0)
                          : const Offset(1.0, 0.0),
                      end: Offset.zero,
                    ).animate(animation);

                    return SlideTransition(
                      position: offsetAnimation,
                      child: child,
                    );
                  },

                  child: loginView ? LoginForm(key: const ValueKey('loginForm'), swapViewMethod: switchView, googleOverlayMethod: switchOverlay, updateFormCompletion: widget.updateFormCompletion,)
                      : SignupForm(key: const ValueKey('signupForm'), swapViewMethod: switchView,
                  ),
                )
              ],
            )
          ),
          IgnorePointer(
            ignoring: !googleOverlay,
            child: AnimatedOpacity(
              opacity: googleOverlay ? 1 : 0,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOutCubic,
              child: Container(
                color: const Color.fromRGBO(217, 217, 217, 0.7),
                child: GestureDetector(
                  onTap: () {
                    _googleOverlayKey.currentState?.resetForm();
                    switchOverlay();
                  },
                ),
              ),
            ),
          ),
          IgnorePointer(
            ignoring: !googleOverlay,
            child: GoogleOauthOverlay(
              key: _googleOverlayKey,
              active: googleOverlay,
            ),
          ),
        ],
      ),
    );
  }
}

class SignupForm extends StatelessWidget {

  final VoidCallback? swapViewMethod;

  const SignupForm({super.key, this.swapViewMethod});

  void _formCompleted(bool completed) {

  }

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.62,
            child: Column(
              children: [
                AccountInputField(
                  fieldHint: "Username",
                  hideFieldToggle: false,
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.05,),
                AccountInputField(
                  fieldHint: "Password",
                  hideFieldToggle: false,
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.05,),
                AccountInputField(
                  fieldHint: "Repeat Password",
                  hideFieldToggle: false,
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.1,),
                AccountProceedButton(
                  active: true,
                  buttonText: "Sign up",
                  updateFormCompletion: _formCompleted,
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.11,),
                AlternateOptionBorder(),
                SizedBox(height: MediaQuery.of(context).size.width * 0.11,),
                AlternateSignUpButton(
                  buttonText: "Log in",
                  thirdPartyLogin: false,
                  onTap: swapViewMethod,
                ),
              ],
            )
        )
    );
  }
}

class LoginForm extends StatelessWidget {

  final ValueChanged<bool> updateFormCompletion;
  final VoidCallback? swapViewMethod;
  final VoidCallback? googleOverlayMethod;

  const LoginForm({super.key, this.swapViewMethod, required this.updateFormCompletion, this.googleOverlayMethod});

  bool filledFields() {

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.62,
            child: Column(
              children: [
                AccountInputField(
                  fieldHint: "Username",
                  hideFieldToggle: false,
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.05,),
                AccountInputField(
                  fieldHint: "Password",
                  hideFieldToggle: true,
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.025,),
                Container(
                    width: MediaQuery.of(context).size.width - 70,
                    height: 30,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Forgot password?",
                        style: const TextStyle(
                          fontFamily: 'InstrumentSans',
                          color: Color.fromRGBO(155, 155, 155, 1),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.05,),
                AccountProceedButton(
                  active: true,
                  buttonText: "Log in",
                  updateFormCompletion: updateFormCompletion,
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.11,),
                AlternateOptionBorder(),
                SizedBox(height: MediaQuery.of(context).size.width * 0.11,),
                AlternateSignUpButton(
                  buttonText: "Log in with Google",
                  buttonIcon: 'assets/icons/googleSignin.png',
                  thirdPartyLogin: true,
                  onTap: googleOverlayMethod,
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.05,),
                AlternateSignUpButton(
                  buttonText: "Log in with Apple",
                  buttonIcon: 'assets/icons/appleSignin.png',
                  thirdPartyLogin: true,
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.05,),
                AlternateSignUpButton(
                  buttonText: "Sign up",
                  thirdPartyLogin: false,
                  onTap: swapViewMethod,
                )
              ],
            )
        )
    );
  }
}

class AlternateSignUpButton extends StatefulWidget {

  final bool thirdPartyLogin;
  final String buttonText;
  final String? buttonIcon;
  final VoidCallback? onTap;

  AlternateSignUpButton({Key? key, required this.buttonText, this.buttonIcon, required this.thirdPartyLogin, this.onTap}) : super(key: key);

  @override
  State<AlternateSignUpButton> createState() => _AlternateSignUpButton();
}

class _AlternateSignUpButton extends State<AlternateSignUpButton> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(
              color: Color.fromRGBO(172, 172, 172, 1.0),
              width: 1.5,
              style: BorderStyle.solid,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          width: MediaQuery.of(context).size.width * 0.84,
          height: MediaQuery.of(context).size.width * 0.12,
          child: Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.thirdPartyLogin)
                    Container(
                        width: 28,
                        height: 28,
                        child: Image.asset(widget.buttonIcon.toString(), scale: 2)
                    ),
                  SizedBox(width: 12,),
                  Text(
                    widget.buttonText.toString(),
                    style: const TextStyle(
                      fontFamily: 'InstrumentSans',
                      color: Color.fromRGBO(105, 93, 93, 1),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
          )
      )
    );
  }
}

class AlternateOptionBorder extends StatelessWidget {

  const AlternateOptionBorder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.84,
      child: Row(
        children: [
          Container(
            height: 2,
            width: MediaQuery.of(context).size.width * 0.35,
            color: Color.fromRGBO(172, 172, 172, 1),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.028,),
          Text(
            "OR",
            style: TextStyle(
              fontFamily: 'InstrumentSans',
              color: Color.fromRGBO(105, 93, 93, 1),
              fontSize: MediaQuery.of(context).size.width * 0.046,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.028,),
          Container(
            height: 2,
            width: MediaQuery.of(context).size.width * 0.35,
            color: Color.fromRGBO(172, 172, 172, 1),
          ),
        ],
      ),
    );
  }
}

class AccountProceedButton extends StatefulWidget {

  final bool active;
  final String buttonText;
  final VoidCallback? onTap;
  final ValueChanged<bool> updateFormCompletion;

  AccountProceedButton({Key? key, required this.active, required this.buttonText, this.onTap, required this.updateFormCompletion}) : super(key: key);

  @override
  State<AccountProceedButton> createState() => _AccountProceedButton();

}

class _AccountProceedButton extends State<AccountProceedButton> {

  void onTap() {
    widget.updateFormCompletion(true);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          width: MediaQuery.of(context).size.width * 0.84,
          height: MediaQuery.of(context).size.width * 0.12,
          decoration: BoxDecoration(
            color: widget.active ? Color.fromRGBO(166, 173, 253, 1.0) : Color.fromRGBO(171, 171, 171, 1.0),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              widget.buttonText,
              style: TextStyle(
                fontFamily: 'InstrumentSans',
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.height * 0.017,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
      ),
    );
  }
}

class AccountInputField extends StatefulWidget {

  final String fieldHint;
  final bool hideFieldToggle;

  AccountInputField({Key? key, required this.fieldHint, required this.hideFieldToggle}) : super(key: key);

  @override
  State<AccountInputField> createState() => _AccountInputField();
}

class _AccountInputField extends State<AccountInputField> {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
          color: Color.fromRGBO(172, 172, 172, 1.0),
          width: 1.5,
          style: BorderStyle.solid,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      height: MediaQuery.of(context).size.width * 0.12,
      width: MediaQuery.of(context).size.width * 0.84,
      child: Stack(
        children: [
          TextField(
            keyboardType: TextInputType.number,
            style: TextStyle(
                color: Color.fromRGBO(105, 93, 93, 1),
                fontFamily: 'InstrumentSans',
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.height * 0.017
            ),
            decoration: InputDecoration(
              hintText: widget.fieldHint,
              hintStyle: TextStyle(
                  color: Color.fromRGBO(105, 93, 93, 1),
                  fontFamily: 'InstrumentSans',
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.height * 0.017
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left: 18.0),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.75, top: MediaQuery.of(context).size.height * 0.015),
            child: widget.hideFieldToggle ? Icon(Icons.visibility_off, color: Color.fromRGBO(172, 172, 172, 1), size: MediaQuery.of(context).size.height * 0.025,) : Icon(Icons.remove_red_eye_rounded, color: Color.fromRGBO(172, 172, 172, 0), size: MediaQuery.of(context).size.height * 0.025),
          ),
        ],
      ),
    );
  }
}
