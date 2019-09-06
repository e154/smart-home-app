import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ButtonScenarios extends StatelessWidget {
  final Function function;
  final String name;
  final bool active;

  ButtonScenarios(this.function, this.name, this.active);

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
        onTap: () => function,
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
                    color: active ? Colors.green : Colors.grey,
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
                    Text(name),
                  ],
                )),
              )),
        ));
    ;
  }
}
