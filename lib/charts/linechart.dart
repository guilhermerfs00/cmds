import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmds/data/sensor.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class LineChart extends StatefulWidget {
  @override
  _LineChartState createState() => _LineChartState();
}

class _LineChartState extends State<LineChart> {
  List<charts.Series<Sensor, String>> _seriesBarData;
  List<Sensor> mydata;

  _generateData(mydata) {
    _seriesBarData = List<charts.Series<Sensor, String>>();
    _seriesBarData.add(
      charts.Series(
        domainFn: (Sensor sensor, _) => sensor.date.toString(),
        measureFn: (Sensor sensor, _) => sensor.value,
        colorFn: (Sensor sensor, _) =>
            charts.ColorUtil.fromDartColor(Color(int.parse(sensor.color))),
        id: 'Sensor',
        data: mydata,
        labelAccessorFn: (Sensor row, _) => "${row.date}",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sensor')),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('sensor').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LinearProgressIndicator();
        } else {
          List<Sensor> sensor = snapshot.data.documents
              .map((documentSnapshot) => Sensor.fromMap(documentSnapshot.data))
              .toList();
          return _buildChart(context, sensor);
        }
      },
    );
  }

  Widget _buildChart(BuildContext context, List<Sensor> sensorData) {
    mydata = sensorData;
    _generateData(mydata);
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                'Sensores por ano',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10.0,
              ),
              Expanded(
                child: charts.BarChart(
                  _seriesBarData,
                  animate: true,
                  animationDuration: Duration(seconds: 5),
                  behaviors: [
                    new charts.DatumLegend(
                      entryTextStyle: charts.TextStyleSpec(
                          color: charts.MaterialPalette.purple.shadeDefault,
                          fontFamily: 'Georgia',
                          fontSize: 18),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
