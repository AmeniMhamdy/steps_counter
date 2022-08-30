//import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:steps_counter/providers/count.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Chart extends StatefulWidget {
  // const Chart({Key? key}) : super(key: key);

  @override
  State<Chart> createState() => _ChartState();
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double? y;
}

class _ChartState extends State<Chart> {
  List<ChartData> chartData = [];

  @override
  void initState() {
    // TODO: implement initState
    //getData();
    super.initState();
  }

  getData() {
    int dt = DateTime.now().day;
    List<ChartData> chartData2 = [];
    List<Pas> list = Provider.of<Count>(context, listen: false).getList();
    list.forEach(
      (element) {
        chartData2.add(
          ChartData(dt.toString(), element.step),
        );
      },
    );

    ///
    setState(() {
      chartData = chartData2;
    });
    print(chartData);

    /*Future _create() async {
      final userCollection = FirebaseFirestore.instance.collection("users");
      final docRef = userCollection.doc('user-id');
      await docRef.set({"date": dt, "step": Step});
    }

  _create();*/
  }

/*TextButton(

  onPressed: () {_create();},
  child: Text('TextButton'),
)
*/
  @override
  Widget build(BuildContext context) {
    ///...
    return Container(
      height: 200,
      child: SfCartesianChart(
          primaryXAxis: CategoryAxis(
            majorGridLines: MajorGridLines(width: 0),
            labelPlacement: LabelPlacement.onTicks,
            edgeLabelPlacement: EdgeLabelPlacement.shift,
            isVisible: true,
            labelStyle: TextStyle(color: Colors.black, fontSize: 15),
          ),
          primaryYAxis: NumericAxis(
              labelStyle: TextStyle(color: Colors.transparent, fontSize: 0)),
          series: <ChartSeries>[
            SplineSeries<ChartData, String>(
                dataSource: Provider.of<Count>(context).myChartData,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y,
                color: Colors.black,
                markerSettings: const MarkerSettings(
                  isVisible: true,
                  width: 4,
                  color: Color.fromARGB(255, 8, 93, 135),
                  borderColor: Colors.orangeAccent,
                ),
                width: 4)
          ]),
    );
  }
}
