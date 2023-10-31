import 'package:flutter/material.dart';
import 'package:penny_smart_wallet/Views/view_add/add_view.dart';
import 'package:penny_smart_wallet/Views/view_calculation/calculation.dart';
import 'package:penny_smart_wallet/Views/view_home/home.dart';
import 'package:penny_smart_wallet/Views/view_statistics/statistics.dart';
import 'package:penny_smart_wallet/Views/view_settings/settings_screen.dart';

class Bottom extends StatefulWidget {
  const Bottom({Key? key}) : super(key: key);

  @override
  State<Bottom> createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  int index_color = 0;
  List Screen = [Home(), Statistics(), Calculation(), AccountScreen()];

  bool shouldShowAddButton = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Screen[index_color],
      floatingActionButton: shouldShowAddButton
          ? FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Add_Screen()));
              },
              child: Icon(Icons.add),
              backgroundColor: Colors.deepPurple,
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.only(top: 7.5, bottom: 7.5),
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
                    shouldShowAddButton = true;
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
