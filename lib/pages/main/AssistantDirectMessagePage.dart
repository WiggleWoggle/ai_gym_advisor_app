import 'package:flutter/material.dart';

class AssistantDirectMessagePage extends StatefulWidget {
  const AssistantDirectMessagePage({super.key});

  @override
  State<AssistantDirectMessagePage> createState() =>
      _AssistantDirectMessagePageState();
}

class _AssistantDirectMessagePageState extends State<AssistantDirectMessagePage> {

  bool blurBackground = false;

  void toggleBlurredBackground() {
    setState(() {
      blurBackground = !blurBackground;
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
                child: Image.asset(
                  'assets/icons/menuright.png',
                  scale: MediaQuery.of(context).size.width * 0.05,
                  color: Color.fromRGBO(75, 75, 75, 1),
                ),
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