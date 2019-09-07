import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smart_home_app/models/models.dart';
import 'package:smart_home_app/widgets/scenes_favorite_editor.dart';

import 'button_scenarios.dart';

class ScenesFavorite extends StatelessWidget {
  final List<int> favorite;
  final Workflow workflow;

  const ScenesFavorite({Key key, this.favorite, this.workflow}) : super(key: key);

  List<Widget> _buttonBuilder() {
    List<Widget> items = new List<Widget>();
    if (favorite == null || favorite.length == 0) {
      items.add(Center(
        child: Text('Long press to add item'),
      ));
    } else {
      if (workflow != null) {
        workflow.scenarios.forEach((scenario) {
          if (favorite.contains(scenario.id)) {
            final newItem = ButtonScenarios(
                function: () {
                  print("Container clicked: " + scenario.id.toString());
                },
                name: scenario.name,
                active: scenario.id == 1);
            items.add(newItem);
          }
        });
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
            child: new GestureDetector(
              onLongPressEnd: (LongPressEndDetails details) {
                print("long press end");
                () async {
                  final scenes = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SceneFavoriteEditor(),
                    ),
                  );
                  if (scenes != null) {
                    print('selected scenes: $scenes');
                    //...
                  } else {
                    print('scenes not selected');
                  }
                }();
              },
              child: Container(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: _buttonBuilder(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
