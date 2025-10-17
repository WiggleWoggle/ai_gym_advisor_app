import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
          Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                SizedBox(height: 130),
                RoutineWidget(),
                SizedBox(height: 40),
                CalendarWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RoutineWidget extends StatefulWidget {
  const RoutineWidget({super.key});

  @override
  State<RoutineWidget> createState() => _RoutineWidgetState();
}

class _RoutineWidgetState extends State<RoutineWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 70,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
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
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 320,
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                      "Your Routine",
                      style: const TextStyle(
                        fontFamily: 'InstrumentSans',
                        color: Color.fromRGBO(100, 100, 100, 1),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Icon(Icons.arrow_forward_ios_rounded, color: Color.fromRGBO(75, 75, 75, 1), size: 20,)
                  )
                ],
              ),
            )
          ),
        ],
      ),
    );
  }
}

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 70,
      height: 250,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
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
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 20, top: 20),
              child: Text(
                "This week\'s progress",
                style: const TextStyle(
                  fontFamily: 'InstrumentSans',
                  color: Color.fromRGBO(100, 100, 100, 1),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: 25),
          Container(
            width: 320,
            height: 70,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 320,
                  height: 70,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(0.0, 1.7),
                      end: Alignment(0.0, 0.2),
                      colors: [
                        Color.fromRGBO(166, 173, 253, 1),
                        Color.fromRGBO(255, 255, 255, 0),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    BarGraphBarWidget(dayProgressPercent: 100),
                    BarGraphBarWidget(dayProgressPercent: 40),
                    BarGraphBarWidget(dayProgressPercent: 70),
                    BarGraphBarWidget(dayProgressPercent: 30),
                    BarGraphBarWidget(dayProgressPercent: 80),
                    BarGraphBarWidget(dayProgressPercent: 15),
                    BarGraphBarWidget(dayProgressPercent: 60),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 5),
          Container(
            width: 310,
            height: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Su",
                  style: const TextStyle(
                    fontFamily: 'InstrumentSans',
                    color: Color.fromRGBO(100, 100, 100, 1),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Mo",
                  style: const TextStyle(
                    fontFamily: 'InstrumentSans',
                    color: Color.fromRGBO(100, 100, 100, 1),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Tu",
                  style: const TextStyle(
                    fontFamily: 'InstrumentSans',
                    color: Color.fromRGBO(100, 100, 100, 1),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "We",
                  style: const TextStyle(
                    fontFamily: 'InstrumentSans',
                    color: Color.fromRGBO(100, 100, 100, 1),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Th",
                  style: const TextStyle(
                    fontFamily: 'InstrumentSans',
                    color: Color.fromRGBO(100, 100, 100, 1),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Fr",
                  style: const TextStyle(
                    fontFamily: 'InstrumentSans',
                    color: Color.fromRGBO(100, 100, 100, 1),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Sa",
                  style: const TextStyle(
                    fontFamily: 'InstrumentSans',
                    color: Color.fromRGBO(100, 100, 100, 1),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 25),
          Stack(
            children: [
              Container(
                width: 320,
                height: 45,
                child: Column(
                  children: [
                    PercentLineWidget(
                      percent: 138,
                      percentSubtext: "more progress this week",
                    ),
                    SizedBox(height: 3),
                    PercentLineWidget(
                      percent: 20,
                      percentSubtext: "closer to finishing this routine",
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 300, top: 20),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Color.fromRGBO(75, 75, 75, 1),
                  size: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PercentLineWidget extends StatelessWidget {
  final int percent;
  final String percentSubtext;

  const PercentLineWidget({
    super.key,
    required this.percent,
    required this.percentSubtext,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          percent.toString() + "%",
          style: const TextStyle(
            fontFamily: 'InstrumentSans',
            color: Color.fromRGBO(172, 178, 253, 1.0),
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 5),
        Text(
          percentSubtext,
          style: const TextStyle(
            fontFamily: 'InstrumentSans',
            color: Color.fromRGBO(100, 100, 100, 1),
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class BarGraphBarWidget extends StatelessWidget {
  final int dayProgressPercent;

  const BarGraphBarWidget({super.key, required this.dayProgressPercent});

  double height() {
    final clampedPercent = dayProgressPercent.clamp(0, 100);

    return (clampedPercent / 100) * 80;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: height(),
      decoration: BoxDecoration(
        color: Color.fromRGBO(172, 178, 253, 1.0),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(4),
          topLeft: Radius.circular(4),
        ),
      ),
    );
  }
}
