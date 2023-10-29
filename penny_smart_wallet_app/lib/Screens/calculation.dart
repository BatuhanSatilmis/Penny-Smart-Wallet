import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:penny_smart_wallet/data/model/add_date.dart';
import 'package:penny_smart_wallet/data/utlity.dart';
import 'package:animate_do/animate_do.dart';

class Calculation extends StatefulWidget {
  @override
  _CalculationWidgetState createState() => _CalculationWidgetState();
}

class _CalculationWidgetState extends State<Calculation> {
  List<Add_data> todayData = [];
  List<Add_data> weekData = [];
  List<Add_data> monthData = [];
  List<Add_data> yearData = [];
  int totalToday = 0;
  int totalWeek = 0;
  int totalMonth = 0;
  int totalYear = 0;

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  void initializeData() async {
    await Hive.openBox<Add_data>('data');

    todayData = today();
    weekData = week();
    monthData = month();
    yearData = year();

    // Yıllara göre verileri gruplandırın
    Map<int, Map<int, List<Add_data>>> yearlyData = groupDataByYear();

    totalToday = total_chart(todayData);
    totalWeek = total_chart(weekData);
    totalMonth = total_chart(monthData);
    int specificYear = 2023;

    if (yearlyData.containsKey(specificYear)) {
      totalYear = total_chart(
          yearlyData[specificYear]!.values.expand((data) => data).toList());
    } else {
      totalYear =
          0; // Eğer belirli bir yıl için veri yoksa, totalYear'ı sıfırla.
    }

    setState(() {});
  }

  Map<int, Map<int, List<Add_data>>> groupDataByYear() {
    // Verileri yıllara ve aylara göre gruplandırın
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

  // Harcamaların aylık ve yıllık tahminini hesapla
  int calculateMonthlyEstimate(int total, int daysElapsed) {
    if (daysElapsed <= 0) return total;
    double dailyAverage = total / daysElapsed;
    int remainingDaysInMonth = 30 - daysElapsed; // Basit bir varsayım
    return (total + dailyAverage * remainingDaysInMonth).toInt();
  }

  num calculateYearlyEstimate(int monthlyTotal, int currentMonth) {
    if (currentMonth <= 0) return monthlyTotal;
    return monthlyTotal * 12 / currentMonth;
  }

  @override
  Widget build(BuildContext context) {
    int daysElapsed = DateTime.now().day;
    int currentMonth = DateTime.now().month;

    int monthlyTotalToday = calculateMonthlyEstimate(totalToday, daysElapsed);
    num yearlyTotalToday =
        calculateYearlyEstimate(monthlyTotalToday, currentMonth);

    int monthlyTotalWeek = calculateMonthlyEstimate(totalWeek, daysElapsed);
    num yearlyTotalWeek =
        calculateYearlyEstimate(monthlyTotalWeek, currentMonth);

    int monthlyTotalMonth = calculateMonthlyEstimate(totalMonth, daysElapsed);
    num yearlyTotalMonth =
        calculateYearlyEstimate(monthlyTotalMonth, currentMonth);

    return Scaffold(
      backgroundColor: Colors.black, // Arka planı siyah yapın
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Akıllı Harcama Hesaplama",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Metin rengini beyaz yapın
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
                  yearlyEstimate: yearlyTotalToday,
                  cardColor: Colors.deepPurple,
                ),
                DataCard(
                  title: "Haftalık Harcamalar",
                  total: totalWeek,
                  monthlyEstimate: monthlyTotalWeek,
                  yearlyEstimate: yearlyTotalWeek,
                  cardColor: Color.fromARGB(255, 121, 28, 0),
                ),
                DataCard(
                  title: "Aylık Harcamalar",
                  total: totalMonth,
                  monthlyEstimate: monthlyTotalMonth,
                  yearlyEstimate: yearlyTotalMonth,
                  cardColor: Color.fromARGB(255, 0, 73, 4),
                ),
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
  final num yearlyEstimate;
  final Color cardColor;

  DataCard({
    required this.title,
    required this.total,
    required this.monthlyEstimate,
    required this.yearlyEstimate,
    required this.cardColor,
  });

  @override
  Widget build(BuildContext context) {
    return ZoomIn(
      duration: Duration(seconds: 1), // Animasyon süresi
      child: Container(
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
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
