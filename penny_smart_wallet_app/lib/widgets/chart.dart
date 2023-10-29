import 'package:flutter/material.dart';
import 'package:penny_smart_wallet/data/model/add_date.dart';
import 'package:penny_smart_wallet/data/utlity.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

// ignore: must_be_immutable
class Chart extends StatefulWidget {
  int indexx;
  Chart({Key? key, required this.indexx}) : super(key: key);

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  List<Add_data>? a;
  bool b = true;
  bool j = true;

  @override
  Widget build(BuildContext context) {
    switch (widget.indexx) {
      case 0:
        a = today();
        b = true;
        j = true;
        break;
      case 1:
        a = week();
        b = false;
        j = true;
        break;
      case 2:
        a = month();
        b = false;
        j = true;
        break;
      case 3:
        a = year();
        j = false;
        break;
      default:
    }
    return Column(
      children: [
        Container(
          // color: Colors.black,
          width: double.infinity,
          height: 300,
          child: SfCircularChart(
            series: <DoughnutSeries>[
              DoughnutSeries<SalesData, String>(
                dataSource: <SalesData>[
                  ...List.generate(time(a!, b ? true : false).length, (index) {
                    return SalesData(
                      j
                          ? b
                              ? a![index].datetime.hour.toString()
                              : a![index].datetime.day.toString()
                          : a![index].datetime.month.toString(),
                      b
                          ? index > 0
                              ? time(a!, true)[index] +
                                  time(a!, true)[index - 1]
                              : time(a!, true)[index]
                          : index > 0
                              ? time(a!, false)[index] +
                                  time(a!, false)[index - 1]
                              : time(a!, false)[index],
                    );
                  }),
                ],
                xValueMapper: (SalesData sales, _) => sales.year,
                yValueMapper: (SalesData sales, _) => sales.sales,
                dataLabelSettings: DataLabelSettings(isVisible: true),
              ),
            ],
          ),
        ),
        Container(
          //  color: Colors.black,
          width: double.infinity,
          height: 300,
          child: SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            series: <ColumnSeries<SalesData, String>>[
              ColumnSeries<SalesData, String>(
                color: Color.fromARGB(255, 251, 188, 5),
                dataSource: <SalesData>[
                  ...List.generate(time(a!, b ? true : false).length, (index) {
                    return SalesData(
                      j
                          ? b
                              ? a![index].datetime.hour.toString()
                              : a![index].datetime.day.toString()
                          : a![index].datetime.month.toString(),
                      b
                          ? index > 0
                              ? time(a!, true)[index] +
                                  time(a!, true)[index - 1]
                              : time(a!, true)[index]
                          : index > 0
                              ? time(a!, false)[index] +
                                  time(a!, false)[index - 1]
                              : time(a!, false)[index],
                    );
                  }),
                ],
                xValueMapper: (SalesData sales, _) => sales.year,
                yValueMapper: (SalesData sales, _) => sales.sales,
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: 300,
          child: SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            series: <ScatterSeries<SalesData, String>>[
              ScatterSeries<SalesData, String>(
                color: Colors.red,
                dataSource: <SalesData>[
                  ...List.generate(time(a!, b ? true : false).length, (index) {
                    return SalesData(
                      j
                          ? b
                              ? a![index].datetime.hour.toString()
                              : a![index].datetime.day.toString()
                          : a![index].datetime.month.toString(),
                      b
                          ? index > 0
                              ? time(a!, true)[index] +
                                  time(a!, true)[index - 1]
                              : time(a!, true)[index]
                          : index > 0
                              ? time(a!, false)[index] +
                                  time(a!, false)[index - 1]
                              : time(a!, false)[index],
                    );
                  }),
                ],
                xValueMapper: (SalesData sales, _) => sales.year,
                yValueMapper: (SalesData sales, _) => sales.sales,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final int sales;
}
