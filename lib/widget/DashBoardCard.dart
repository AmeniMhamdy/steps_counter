import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steps_counter/providers/count.dart';

import '/widget/imageContainer.dart';
import '/widget/textWidget.dart';

import 'package:percent_indicator/linear_percent_indicator.dart';

class dashboardCard extends StatelessWidget {
  int steps;
  double miles, calories, duration;
  dashboardCard(this.steps, this.miles, this.calories, this.duration,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                      child: Column(
                        children: [
                          // this is for the count in foot step and edit button
                          Container(
                            width: 150,
                            child: Row(
                              children: [
                                text(50, Provider.of<Count>(context).steps),
                                SizedBox(
                                  width: 10,
                                ),
                                // this is for edit icon
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: LinearPercentIndicator(
                percent: 01,
                progressColor: Colors.white,
                lineHeight: 5,
                animation: true,
              ),
            ),
            const SizedBox(
              height: 70,
            ),
            // this is botton part
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                imageContainer(
                    "assets/locations.png", miles.toStringAsFixed(3), "Miles"),
                imageContainer("assets/calories.png",
                    calories.toStringAsFixed(3), "Calories"),
                imageContainer("assets/stopwatch.png",
                    duration.toStringAsFixed(3), "Duration"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
