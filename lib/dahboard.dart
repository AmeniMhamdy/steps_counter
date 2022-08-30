import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steps_counter/providers/count.dart';
import '/widget/DashBoardCard.dart';

import '/widget/topTextButton.dart';

import 'package:sensors_plus/sensors_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/widget/doc.dart';
import 'widget/dailyAverage.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  double x = 0.0;
  double y = 0.0;
  double z = 0.0;
  double miles = 0.0;
  double duration = 0.0;
  double calories = 0.0;
  double addValue = 0.025;
  int steps = 0;
  double previousDistacne = 0.0;
  double distance = 0.0;
  List seriesList = [];

  @override
  Widget build(BuildContext context) {
    void increment(BuildContext context) {
      Provider.of<Count>(context, listen: false)
          .incrementCounter(DateTime.now());
      print(DateTime.now());
    }

    return Scaffold(
      body: StreamBuilder<AccelerometerEvent>(
        stream: SensorsPlatform.instance.accelerometerEvents,
        builder: (context, snapShort) {
          if (snapShort.hasData) {
            x = snapShort.data!.x;
            y = snapShort.data!.y;
            z = snapShort.data!.z;
            distance = getValue(x, y, z);
            if (distance > 6) {
              steps++;
              WidgetsBinding.instance.addPostFrameCallback((_) {
                increment(context);
              });
            }
            calories = calculateCalories(steps);
            duration = calculateDuration(steps);
            miles = calculateMiles(steps);
          }
          return Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      Colors.white,
                      Colors.white,
                    ])),
              ),
              // ignore: sized_box_for_whitespace
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: Column(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      SizedBox(
                        height: kToolbarHeight,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          children: [
                            topText("Today", true, () {
                              print("This was tapped");
                            }),
                          ],
                        ),
                      ),
                      // dashboard card
                      dashboardCard(steps, miles, calories, duration),
                      Chart(),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  double getValue(double x, double y, double z) {
    double magnitude = sqrt(x * x + y * y + z * z);
    getPreviousValue();
    double modDistance = magnitude - previousDistacne;
    setPreviousValue(magnitude);
    return modDistance;
  }

  void setPreviousValue(double distance) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.setDouble("preValue", distance);
  }

  void getPreviousValue() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setState(() {
      previousDistacne = _pref.getDouble("preValue") ?? 0.0;
    });
  }

  // void calculate data
  double calculateMiles(int steps) {
    double milesValue = (2.2 * steps) / 5280;
    return milesValue;
  }

  double calculateDuration(int steps) {
    double durationValue = (steps * 1 / 1000);
    return durationValue;
  }

  double calculateCalories(int steps) {
    double caloriesValue = (steps * 0.0566);
    return caloriesValue;
  }
}
