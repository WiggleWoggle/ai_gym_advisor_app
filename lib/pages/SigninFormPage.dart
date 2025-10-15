import 'package:flutter/material.dart';

class SignInFormPage extends StatelessWidget {

  const SignInFormPage({super.key});

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
                colors: [Color.fromRGBO(166, 173, 253, 0.2), Colors.white],
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: 780,
                child: Column(
                  children: [
                    Image.asset(
                      'assets/icons/logo.png',
                      scale: 1.7,
                    ),
                    SizedBox(height: 20,),
                    Text(
                      "Welcome back",
                      style: const TextStyle(
                        fontFamily: 'InstrumentSans',
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 40,),
                    AccountInputField(
                      fieldHint: "Username",
                      hideFieldToggle: false,
                    ),
                    SizedBox(height: 20,),
                    AccountInputField(
                      fieldHint: "Password",
                      hideFieldToggle: true,
                    ),
                    SizedBox(height: 10,),
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
                    SizedBox(height: 20,),
                    AccountProceedButton(active: true),
                    SizedBox(height: 70,),
                    AlternateOptionBorder(),
                    SizedBox(height: 30,),
                    AlternateSignUpButton(
                      buttonText: "Log in with Google",
                      buttonIcon: 'assets/icons/googleSignin.png',
                      thirdPartyLogin: true,
                    ),
                    SizedBox(height: 20,),
                    AlternateSignUpButton(
                      buttonText: "Log in with Apple",
                      buttonIcon: 'assets/icons/appleSignin.png',
                      thirdPartyLogin: true,
                    ),
                    SizedBox(height: 20,),
                    AlternateSignUpButton(
                      buttonText: "Sign up",
                      thirdPartyLogin: false,
                    )
                  ],
                )
            )
          )
        ],
      )
    );
  }
}

class AlternateSignUpButton extends StatefulWidget {

  final bool thirdPartyLogin;
  final String buttonText;
  final String? buttonIcon;

  AlternateSignUpButton({Key? key, required this.buttonText, this.buttonIcon, required this.thirdPartyLogin}) : super(key: key);

  @override
  State<AlternateSignUpButton> createState() => _AlternateSignUpButton();
}

class _AlternateSignUpButton extends State<AlternateSignUpButton> {

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
      width: 360,
      height: 55,
      child: Align(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.thirdPartyLogin)
              Container(
                  width: 30,
                  height: 30,
                  child: Image.asset(widget.buttonIcon.toString(), scale: 2)
              ),
              SizedBox(width: 10,),
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
    );
  }
}

class AlternateOptionBorder extends StatelessWidget {

  const AlternateOptionBorder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 70,
      child: Row(
        children: [
          Container(
            height: 2,
            width: MediaQuery.of(context).size.width - 280,
            color: Color.fromRGBO(172, 172, 172, 1),
          ),
          SizedBox(width: 15,),
          Text(
            "OR",
            style: const TextStyle(
              fontFamily: 'InstrumentSans',
              color: Color.fromRGBO(105, 93, 93, 1),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 15,),
          Container(
            height: 2,
            width: MediaQuery.of(context).size.width - 280,
            color: Color.fromRGBO(172, 172, 172, 1),
          ),
        ],
      ),
    );
  }
}

class AccountProceedButton extends StatefulWidget {

  final bool active;

  AccountProceedButton({Key? key, required this.active}) : super(key: key);

  @override
  State<AccountProceedButton> createState() => _AccountProceedButton();

}

class _AccountProceedButton extends State<AccountProceedButton> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 70,
      height: 50,
      decoration: BoxDecoration(
        color: widget.active ? Color.fromRGBO(166, 173, 253, 1.0) : Color.fromRGBO(171, 171, 171, 1.0),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          "Log in",
          style: const TextStyle(
            fontFamily: 'InstrumentSans',
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      )
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
      width: 360,
      child: Stack(
        children: [
          TextField(
            keyboardType: TextInputType.number,
            style: TextStyle(color: Color.fromRGBO(105, 93, 93, 1)),
            decoration: InputDecoration(
              hintText: widget.fieldHint,
              hintStyle: TextStyle(
                  color: Color.fromRGBO(105, 93, 93, 1),
                  fontFamily: 'InstrumentSans',
                  fontWeight: FontWeight.bold,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left: 18.0),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 320, top: 15),
            child: widget.hideFieldToggle ? Icon(Icons.visibility_off, color: Color.fromRGBO(172, 172, 172, 1)) : Icon(Icons.remove_red_eye_rounded, color: Color.fromRGBO(172, 172, 172, 0)),
          )
        ],
      ),
    );
  }
}

