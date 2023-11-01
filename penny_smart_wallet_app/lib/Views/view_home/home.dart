import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:penny_smart_wallet/data/model/add_date.dart';
import 'package:penny_smart_wallet/data/utlity.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var history;
  final box = Hive.box<Add_data>('data');
  final List<String> day = [
    'Monday',
    "Tuesday",
    "Wednesday",
    "Thursday",
    'Friday',
    'Saturday',
    'Sunday',
  ];

  String selectedCategory = 'All';
  bool isNotificationActive = false;

  void toggleNotification() {
    setState(() {
      isNotificationActive = !isNotificationActive;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text(
                'Penny Smart Wallet',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              actions: <Widget>[
                InkWell(
                  onTap: () {
                    toggleNotification();
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.only(right: 0, top: 10, bottom: 10),
                    child: Ink(
                      decoration: ShapeDecoration(
                        color: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: isNotificationActive ? 2.0 : 1.0,
                          ),
                        ),
                      ),
                      child: Icon(
                        isNotificationActive
                            ? Icons.notifications_active
                            : Icons.notifications,
                        color: Colors.grey.shade50,
                      ),
                    ),
                  ),
                ),
              ],
              backgroundColor: Colors.black,
              expandedHeight: 60,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.fromLTRB(45, 0, 45, 20),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 43, 14, 94),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Center(
                    child: _head(),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.fromLTRB(45, 0, 45, 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: _card(context),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Wrap(
                      alignment: WrapAlignment.spaceEvenly,
                      spacing: 8.0,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            filterByCategory('All');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 34, 34, 34),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: Text('All'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            filterByCategory('Food');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 34, 34, 34),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: Text('Food'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            filterByCategory('Education');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 34, 34, 34),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: Text('Education'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            filterByCategory('Transfer');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 34, 34, 34),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: Text('Transfer'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            filterByCategory('Transportation');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 34, 34, 34),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: Text('Transportation'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  history = box.values.toList()[index];
                  if (selectedCategory == 'All' ||
                      history.name == selectedCategory) {
                    return Padding(
                      padding: EdgeInsets.only(top: 10, left: 40, right: 40),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 34, 34, 34),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: getList(history, index),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
                childCount: box.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void filterByCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  Widget getList(Add_data history, int index) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        history.delete();
      },
      child: get(index, history),
    );
  }

  ListTile get(int index, Add_data history) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Image.asset('images/${history.name}.png', height: 40),
      ),
      title: Text(
        history.name,
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      subtitle: Text(
        '${day[history.datetime.weekday - 1]}  ${history.datetime.year}-${history.datetime.day}-${history.datetime.month}',
        style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
      ),
      trailing: Text(
        history.amount,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 19,
          color: history.IN == 'Income' ? Colors.green : Colors.red,
        ),
      ),
    );
  }

  Widget _head() {
    return Container(
      padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Batuhan Satilmis',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'batuhansatilmis@gmail.com',
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _card(BuildContext context) {
    return Positioned(
      child: Container(
        height: 170,
        decoration: BoxDecoration(
          boxShadow: [],
          color: Color.fromARGB(255, 43, 14, 94),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Balance',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(height: 7),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Row(
                children: [
                  Text(
                    '${total()} ₺',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 13,
                        backgroundColor: Color.fromARGB(255, 31, 61, 6),
                        child: Icon(
                          Icons.arrow_downward,
                          color: Colors.white,
                          size: 19,
                        ),
                      ),
                      SizedBox(width: 7),
                      Text(
                        'Income',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 13,
                        backgroundColor: Color.fromARGB(255, 114, 44, 23),
                        child: Icon(
                          Icons.arrow_upward,
                          color: Colors.white,
                          size: 19,
                        ),
                      ),
                      SizedBox(width: 7),
                      Text(
                        'Expenses',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${income()} ₺',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      color: Colors.green,
                    ),
                  ),
                  Text(
                    '${expenses()} ₺',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
