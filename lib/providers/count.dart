import 'package:flutter/material.dart';

import '../widget/dailyAverage.dart';

class Count extends ChangeNotifier {
  int count = 0;
  List<Pas> list = [];
  List<ChartData> chartData = [];
  List<ChartData> get myChartData => chartData;
  String get steps => count.toString();
  getCount() => count;
  List<Pas> getList() => list;
  void incrementCounter(DateTime date) {
    if (list.isEmpty) {
      final m = Pas(
        date,
        1,
      );
      list.add(m);
    } else {
      for (int i = 0; i < list.length; i++) {
        var index = -1;
        if (list[i].date.day == date.day) {
          index = i;
        }
        if (index >= 0) {
          list[index].step++;
        } else {
          final m = Pas(
            date,
            0,
          );
          list.add(m);
        }
      }
    }
    print(list);
    list.forEach(
      (element) {
        print(element.date);
        print(element.step);
        var dt = DateTime.now().day;
        chartData.add(
          ChartData(dt.toString(), element.step),
        );
      },
    );
    count++;
    notifyListeners();
  }
}

class Pas {
  DateTime date;
  double step;
  Pas(this.date, this.step);
}
