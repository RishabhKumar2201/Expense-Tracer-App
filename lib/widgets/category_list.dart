import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:tracker_application/utils/icons_list.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key, required this.onChanged});
  final ValueChanged<String> onChanged;

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  String currentCategory = "";

  final scrollController = ScrollController();
  var appIcons = AppIcons();
  List<Map<String, dynamic>> categorylist = [];
  var addCat = {
    "name": "All",
    "icon": FontAwesomeIcons.cartPlus,
  };

  @override
  void initState() {
    super.initState();
    setState(() {
      categorylist = appIcons.homeExpensesCategories;
      categorylist.insert(0, addCat);
    });

  }

  // scrollToSelectedMonth() {
  //   final selectedMonthIndex = categorylist.indexOf(categorylist);
  //   if (selectedMonthIndex != -1) {
  //     final scrollOffset = (selectedMonthIndex * 100.0) - 170;
  //     scrollController.animateTo(scrollOffset,
  //         duration: Duration(milliseconds: 500), curve: Curves.ease);
  //   }
  // }

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 55,
      child: ListView.builder(
          controller: scrollController,
          itemCount: categorylist.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            var data = categorylist[index];
            return InkWell(
              onTap: () {
                setState(() {
                  currentCategory = data['name'];
                  widget.onChanged(data['name']);
                });
              },
              highlightColor: Colors.red, // Set custom highlight color
              splashColor: Colors.blue,
              borderRadius: BorderRadius.circular(15),

              child: Container(
                //width: 80,
                padding: EdgeInsets.only(left: 10, right: 10),
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: currentCategory == data['name']
                      ? Colors.orange.shade900
                      : Colors.blue.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                    child: Row(
                  children: [
                    Icon(
                      data['icon'],
                      size: 17,
                      color: currentCategory == data['name']
                          ? Colors.white
                          : Colors.purple,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      data['name'],
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: currentCategory == data['name']
                            ? Colors.white
                            : Colors.purple,
                      ),
                    ),
                  ],
                )),
              ),
            );
          }),
    );
  }
}
