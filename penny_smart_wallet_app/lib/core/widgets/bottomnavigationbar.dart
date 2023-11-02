import 'package:flutter/material.dart';
import 'package:penny_smart_wallet/app/routes/app_router.dart';
import 'package:penny_smart_wallet/app/views/view_calculation/calculation.dart';
import 'package:penny_smart_wallet/app/views/view_home/home.dart';
import 'package:penny_smart_wallet/app/views/view_statistics/statistics_view.dart';
import 'package:penny_smart_wallet/app/views/view_settings/settings_view.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class BottomView extends StatefulWidget {
  const BottomView({Key? key}) : super(key: key);

  @override
  State<BottomView> createState() => _BottomState();
}

class _BottomState extends State<BottomView> {
  int index_color = 0;
  List Screen = [
    HomeView(),
    StatisticsView(),
    CalculationView(),
    SettingsView()
  ];

  bool shouldShowAddButton = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Screen[index_color],
      floatingActionButton: shouldShowAddButton
          ? FloatingActionButton(
              onPressed: () {
                context.router.replace(AddViewRoute());
              },
              child: Icon(Icons.add),
              backgroundColor: Colors.deepPurple,
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.only(top: 5.5, bottom: 5.5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    index_color = 0;
                    shouldShowAddButton = true;
                  });
                },
                child: Icon(
                  Icons.home,
                  size: 30,
                  color: index_color == 0 ? Colors.deepPurple : Colors.grey,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    index_color = 1;
                    shouldShowAddButton = false;
                  });
                },
                child: Icon(
                  Icons.bar_chart_outlined,
                  size: 30,
                  color: index_color == 1 ? Colors.deepPurple : Colors.grey,
                ),
              ),
              SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  setState(() {
                    index_color = 2;
                    shouldShowAddButton = true;
                  });
                },
                child: Icon(
                  Icons.calculate_outlined,
                  size: 30,
                  color: index_color == 2 ? Colors.deepPurple : Colors.grey,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    index_color = 3;
                    shouldShowAddButton = false;
                  });
                },
                child: Icon(
                  Icons.settings_outlined,
                  size: 30,
                  color: index_color == 3 ? Colors.deepPurple : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
