import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ButtonScenarioPlus extends StatelessWidget {
  final Function function;

  ButtonScenarioPlus(this.function);

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
        onTap: () => function,
        child: Container(
          width: 120.0,
          padding: EdgeInsets.all(5),
          child: Container(
              decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.all(const Radius.circular(12.0)),
                boxShadow: [
                  new BoxShadow(
                    blurRadius: 10,
                    color: Colors.grey[50],
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
                    Icon(Icons.add),
//                    Text('add scenario'),
                  ],
                )),
              )),
        ));
    ;
  }
}
