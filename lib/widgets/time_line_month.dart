import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeLineMonth extends StatefulWidget {
  const TimeLineMonth({super.key, required this.onChanged});
  final ValueChanged<String> onChanged;

  @override
  State<TimeLineMonth> createState() => _TimeLineMonthState();
}

class _TimeLineMonthState extends State<TimeLineMonth> {
  String currentMonth = "";
  List<String> months = [];
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    for (int i = -18; i <= 0; i++) {
      months.add(
          DateFormat('MMM y').format(DateTime(now.year, now.month + i, 1)));
    }
    currentMonth = DateFormat('MMM y').format(now);

    Future.delayed(Duration(seconds: 1), () {
      scrollToSelectedMonth();
    });
  }

  scrollToSelectedMonth() {
    final selectedMonthIndex = months.indexOf(currentMonth);
    if (selectedMonthIndex != -1) {
      final scrollOffset = (selectedMonthIndex * 100.0) - 170;
      scrollController.animateTo(scrollOffset,
          duration: Duration(milliseconds: 500), curve: Curves.ease);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      child: ListView.builder(
          controller: scrollController,
          itemCount: months.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                setState(() {
                  currentMonth = months[index];
                  widget.onChanged(months[index]);
                });
                scrollToSelectedMonth();
              },
              highlightColor: Colors.red, // Set custom highlight color
              splashColor: Colors.blue,
              borderRadius: BorderRadius.circular(15),

              child: Container(
                width: 80,
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: currentMonth == months[index]
                      ? Colors.orange.shade900
                      : Colors.purple.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                    child: Text(
                  months[index],
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: currentMonth == months[index]
                        ? Colors.white
                        : Colors.purple,
                  ),
                )),
              ),
            );
          }),
    );
  }
}
