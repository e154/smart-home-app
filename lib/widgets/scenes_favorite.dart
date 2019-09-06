import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smart_home_app/models/models.dart';

class ScenesFavorite extends StatelessWidget {
  final List<int> favorite;
  final Workflow workflow;

  const ScenesFavorite({Key key, this.favorite, this.workflow}) : super(key: key);

  List<Widget> _buttonBuilder() {
    List<Widget> items = new List<Widget>();
    if (favorite == null || favorite.length == 0) {
      items.add(new GestureDetector(
        onTap: () {
          print("Container clicked");
        },
        child: Container(
          width: 100.0,
          color: Colors.red,
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.add),
              Text('add scenario'),
            ],
          )),
        ),
      ));
    } else {
      if (workflow != null) {
        workflow.scenarios.forEach((scenario) {
          if (favorite.contains(scenario.id)) {
            final newItem = new GestureDetector(
                onTap: () {
                  print("Container clicked");
                },
                child: Container(
                  width: 120.0,
                  padding: EdgeInsets.all(5),
                  child: Container(
                      decoration: new BoxDecoration(
                        color: Color.fromRGBO(234, 235, 235, 1),
                        borderRadius: new BorderRadius.all(const Radius.circular(12.0)),
                        boxShadow: [
                          new BoxShadow(
                            blurRadius: 10,
                            color: Colors.grey,
                            spreadRadius: 0,
                            offset: new Offset(3, 3),
                          )
                        ],
                      ),
                      width: 100.0,
//                color: Colors.grey,
                      child: Container(
                        padding: EdgeInsets.all(5),
                        child: Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(scenario.name),
                          ],
                        )),
                      )),
                ));
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
      height: 140,
//      color: Colors.green,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: _buttonBuilder(),
      ),
    );
  }
}
