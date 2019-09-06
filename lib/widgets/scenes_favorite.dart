import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smart_home_app/models/models.dart';
import 'package:smart_home_app/widgets/button_scenario_plus.dart';

import 'button_scenarios.dart';

class ScenesFavorite extends StatelessWidget {
  final List<int> favorite;
  final Workflow workflow;

  const ScenesFavorite({Key key, this.favorite, this.workflow}) : super(key: key);

  List<Widget> _buttonBuilder() {
    List<Widget> items = new List<Widget>();
    if (favorite == null || favorite.length == 0) {
      items.add(ButtonScenarioPlus(() {
        print("Container clicked");
      }));
    } else {
      if (workflow != null) {
        bool exist;
        workflow.scenarios.forEach((scenario) {
          if (favorite.contains(scenario.id)) {
            final newItem = ButtonScenarios(() {
              print("Container clicked");
            }, scenario.name, false);
            items.add(newItem);
          } else {
            exist = true;
          }
        });

        if (exist) {
          items.add(ButtonScenarioPlus(() {
            print("Container clicked");
          }));
        }
      }
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      height: 160,
//      color: Colors.yellow,
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 5),
            height: 20,
            child: Text(
              'Scenarios',
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.left,
            ),
          ),
          new Expanded(
            child: Container(
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: _buttonBuilder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
