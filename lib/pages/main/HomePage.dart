import 'package:flutter/material.dart';
import 'dart:math';

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
                CalendarWidget(dayValues: [100, 40, 70, 30, 80, 15, 60],),
              ],
            ),
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
            "FitnessAdvisor",
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
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Color.fromRGBO(75, 75, 75, 1),
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 30,),
          DynamicPieChartWidget(
            chartTitle: "Days left in routine",
            chartSubtext: "Keep going!",
            currentValue: 67,
            totalValue: 120,
          ),
          SizedBox(height: 30,),
          DynamicPieChartWidget(
            chartTitle: "Calories burned",
            chartSubtext: "340 target",
            currentValue: 128,
            totalValue: 340,
          ),
        ],
      ),
    );
  }
}

class DynamicPieChartWidget extends StatefulWidget {

  final String chartTitle;
  final String chartSubtext;
  final int currentValue;
  final int totalValue;

  const DynamicPieChartWidget({super.key, required this.chartTitle, required this.chartSubtext, required this.currentValue, required this.totalValue});

  @override
  State<DynamicPieChartWidget> createState() => _DynamicPieChartWidgetState();
}

class _DynamicPieChartWidgetState extends State<DynamicPieChartWidget> {

  @override
  Widget build(BuildContext context) {

    double radius = 80;

    return Container(
      width: 320,
      height: 80,
      child: Row(
        children: [
          Container(
            width: radius,
            height: radius,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(90)),
                    color: Color.fromRGBO(212, 212, 212, 1)
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(90)),
                    gradient: RadialGradient(
                      colors: [Colors.white, Color.fromRGBO(166, 173, 253, 1)],
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: radius - 12,
                    height: radius - 12,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(90)),
                        color: Colors.white
                    ),
                    child: Center(
                      child: Text(
                        widget.currentValue.toString(),
                        style: const TextStyle(
                          fontFamily: 'InstrumentSans',
                          color: Color.fromRGBO(172, 178, 253, 1),
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15),
            child: Container(
                width: 200,
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.chartTitle,
                      style: const TextStyle(
                        fontFamily: 'InstrumentSans',
                        color: Color.fromRGBO(172, 178, 253, 1),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                     widget.chartSubtext,
                      style: const TextStyle(
                        fontFamily: 'InstrumentSans',
                        color: Color.fromRGBO(100, 100, 100, 1),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
            )
          )
        ],
      ),
    );
  }
}

class CalendarWidget extends StatefulWidget {

  final List<int> dayValues;

  const CalendarWidget({super.key, required this.dayValues});

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
                    BarGraphBarWidget(dayProgressPercent: widget.dayValues[0]),
                    BarGraphBarWidget(dayProgressPercent: widget.dayValues[1]),
                    BarGraphBarWidget(dayProgressPercent: widget.dayValues[2]),
                    BarGraphBarWidget(dayProgressPercent: widget.dayValues[3]),
                    BarGraphBarWidget(dayProgressPercent: widget.dayValues[4]),
                    BarGraphBarWidget(dayProgressPercent: widget.dayValues[5]),
                    BarGraphBarWidget(dayProgressPercent: widget.dayValues[6]),
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
