import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:smart_home_app/common/common.dart';
import 'package:smart_home_app/models/models.dart';

class HomeTabSelector extends StatelessWidget {
  final AppTab activeTab;
  final Function(AppTab) onTabSelected;

  HomeTabSelector({
    Key key,
    @required this.activeTab,
    @required this.onTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      key: ArchSampleKeys.tabs,
      currentIndex: AppTab.values.indexOf(activeTab),
      onTap: (index) => onTabSelected(AppTab.values[index]),
      items: AppTab.values.map((tab) {
        return BottomNavigationBarItem(
          icon: Icon(
            tab == AppTab.favorite ? Icons.list : Icons.show_chart,
            key: tab == AppTab.favorite ? ArchSampleKeys.todoTab : ArchSampleKeys.statsTab,
          ),
          title: Text(tab == AppTab.etc ? "etc" : "favorite"),
        );
      }).toList(),
    );
  }
}
