import 'package:flutter/material.dart';
import 'package:penny_smart_wallet/data/utlity.dart';
import 'package:penny_smart_wallet/widgets/chart.dart'; // Chart widget'ını dahil edin
import '../data/model/add_date.dart';

class Statistics extends StatefulWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  State<Statistics> createState() => _StatisticsState();
}

ValueNotifier<int> kj = ValueNotifier<int>(0);

class _StatisticsState extends State<Statistics> {
  List<String> day = ['Day', 'Week', 'Month', 'Year'];
  List<List<Add_data>> f = [today(), week(), month(), year()];
  List<Add_data> a = [];
  int index_color = 0;
  bool ascendingOrder = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: ValueListenableBuilder<int>(
          valueListenable: kj,
          builder: (BuildContext context, int value, Widget? child) {
            a = f[value];

            sortList();

            return custom(a); // Verileri custom() metoduna iletiyoruz
          },
        ),
      ),
    );
  }

  CustomScrollView custom(List<Add_data> data) {
    // Verileri custom() metoduna parametre olarak ekliyoruz
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              SizedBox(height: 20),
              Text(
                'Statistics',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ...List.generate(
                      4,
                      (index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              index_color = index;
                              kj.value = index;
                            });
                          },
                          child: Container(
                            height: 40,
                            width: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: index_color == index
                                  ? Colors.deepPurple
                                  : Colors.white,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              day[index],
                              style: TextStyle(
                                color: index_color == index
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Chart(
                indexx: index_color,
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Top Spending & Incomes',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: toggleSortingOrder,
                      child: Icon(
                        Icons.swap_vert,
                        size: 25,
                        color: Colors.white,
                      ),
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
            return ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.asset('images/${a[index].name}.png', height: 40),
              ),
              title: Text(
                a[index].name,
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
              subtitle: Text(
                ' ${a[index].datetime.year}-${a[index].datetime.day}-${a[index].datetime.month}',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              trailing: Text(
                a[index].amount,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 19,
                  color: a[index].IN == 'Income' ? Colors.green : Colors.red,
                ),
              ),
            );
          },
          childCount: a.length,
        ))
      ],
    );
  }

  void toggleSortingOrder() {
    setState(() {
      ascendingOrder = !ascendingOrder;
      sortList();
    });
  }

  void sortList() {
    a.sort((item1, item2) {
      if (ascendingOrder) {
        if (item1.IN == 'Income' && item2.IN != 'Income') {
          return -1;
        } else if (item1.IN != 'Income' && item2.IN == 'Income') {
          return 1;
        } else {
          return (double.parse(item2.amount) - double.parse(item1.amount))
              .toInt();
        }
      } else {
        if (item1.IN == 'Income' && item2.IN != 'Income') {
          return 1;
        } else if (item1.IN != 'Income' && item2.IN == 'Income') {
          return -1;
        } else {
          return (double.parse(item1.amount) - double.parse(item2.amount))
              .toInt();
        }
      }
    });
  }
}
