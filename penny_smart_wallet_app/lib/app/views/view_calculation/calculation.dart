import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:penny_smart_wallet/core/data/model/add_date.dart';
import 'package:animate_do/animate_do.dart';
import 'package:penny_smart_wallet/core/data/utlity.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class CalculationView extends StatefulWidget {
  @override
  _CalculationViewWidgetState createState() => _CalculationViewWidgetState();
}

class _CalculationViewWidgetState extends State<CalculationView> {
  List<Add_data> todayData = [];
  List<Add_data> weekData = [];
  List<Add_data> monthData = [];
  List<Add_data> yearData = [];
  int totalToday = 0;
  int totalWeek = 0;
  int totalMonth = 0;
  int totalYear = 0;
  late Box<Add_data> box;

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  void initializeData() async {
    box = await Hive.openBox<Add_data>('data');

    todayData = today();
    weekData = week();
    monthData = month();
    yearData = year();

    Map<int, Map<int, List<Add_data>>> yearlyData = groupDataByYear();

    totalToday = total_chart(todayData);
    totalWeek = total_chart(weekData);
    totalMonth = total_chart(monthData);
    int specificYear = 2023;

    if (yearlyData.containsKey(specificYear)) {
      totalYear = total_chart(
          yearlyData[specificYear]!.values.expand((data) => data).toList());
    } else {
      totalYear = 0;
    }

    setState(() {});
  }

  Map<int, Map<int, List<Add_data>>> groupDataByYear() {
    Map<int, Map<int, List<Add_data>>> groupedData = {};

    for (var data in box.values) {
      int year = data.datetime.year;
      int month = data.datetime.month;

      if (!groupedData.containsKey(year)) {
        groupedData[year] = {};
      }

      if (!groupedData[year]!.containsKey(month)) {
        groupedData[year]![month] = [];
      }

      groupedData[year]![month]!.add(data);
    }

    return groupedData;
  }

  int calculateMonthlyEstimate(int total, int daysElapsed) {
    if (daysElapsed <= 0) return total;
    int remainingDaysInMonth =
        DateTime(DateTime.now().year, DateTime.now().month + 1, 1)
            .subtract(Duration(days: 1))
            .day;
    return (remainingDaysInMonth != 0) ? (total * remainingDaysInMonth).toInt() : total;
  }

  int calculateYearlyEstimate(int monthlyTotal, int currentMonth) {
    if (currentMonth <= 0) return monthlyTotal;
    return (monthlyTotal * 12).toInt();
  }

  int calculateWeeklyEstimate(int total, int daysElapsed) {
    if (daysElapsed <= 0) return total;
    int remainingDaysInWeek = 7 - DateTime.now().weekday;
    return (remainingDaysInWeek != 0) ? (total * (7 / remainingDaysInWeek)).toInt() : total;
  }

  @override
  Widget build(BuildContext context) {
    int daysElapsed = DateTime.now().day;
    int currentMonth = DateTime.now().month;

    int monthlyTotalToday = calculateMonthlyEstimate(totalToday, daysElapsed);

    int weeklyTotalToday = calculateWeeklyEstimate(totalToday, daysElapsed);

    int monthlyTotalWeek = calculateMonthlyEstimate(totalWeek, daysElapsed);

    int monthlyTotalMonth = calculateMonthlyEstimate(totalMonth, daysElapsed);
    int yearlyTotalMonth =
        calculateYearlyEstimate(monthlyTotalMonth, currentMonth);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Akıllı Harcama Hesaplama",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DataCard(
                    title: "Günlük Harcamalar",
                    total: totalToday,
                    monthlyEstimate: monthlyTotalToday,
                    weeklyEstimate: weeklyTotalToday,
                    yearlyEstimate: monthlyTotalToday ,
                    cardColor: Color.fromARGB(255, 41, 17, 2)),
                DataCard( 
                    title: "Haftalık Harcamalar",
                    total: totalWeek,
                    monthlyEstimate: monthlyTotalWeek,
                    weeklyEstimate: weeklyTotalToday,
                    yearlyEstimate: monthlyTotalWeek,
                    cardColor: Color.fromARGB(255, 2, 32, 12)),
                DataCard(
                    title: "Aylık Harcamalar",
                    total: totalMonth,
                    monthlyEstimate: monthlyTotalMonth,
                    weeklyEstimate: weeklyTotalToday,
                    yearlyEstimate: yearlyTotalMonth,
                    cardColor: Color.fromARGB(255, 26, 4, 63)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DataCard extends StatelessWidget {
  final String title;
  final int total;
  final int monthlyEstimate;
  final int weeklyEstimate;
  final int yearlyEstimate;
  final Color cardColor;

  DataCard({
    required this.title,
    required this.total,
    required this.monthlyEstimate,
    required this.weeklyEstimate,
    required this.yearlyEstimate,
    required this.cardColor,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      duration: Duration(seconds: 1),
      child: Container(
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            stops: const [0.1, 1.0],
            colors: [cardColor, cardColor],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Toplam: $total',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              Text(
                'Aylık Tahmin: $monthlyEstimate',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              Text(
                'Yıllık Tahmin: $yearlyEstimate',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
