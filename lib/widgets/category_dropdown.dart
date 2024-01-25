import 'package:flutter/material.dart';
import 'package:tracker_application/utils/icons_list.dart';

class CategoryDropDown extends StatelessWidget {
  CategoryDropDown({super.key, this.cattype, required this.onChanged});
  var appIcon = AppIcons();
  final String? cattype;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
        value: cattype,
        isExpanded: true,
        hint: Text("Select Category"),
        items: appIcon.homeExpensesCategories
            .map((e) => DropdownMenuItem<String>(
                value: e['name'],
                child: Row(
                  children: [
                    Icon(
                      e['icon'],
                      color: Colors.black54,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      e["name"],
                      style: TextStyle(color: Colors.black45),
                    ),
                  ],
                )))
            .toList(),
        onChanged: onChanged);
  }
}
