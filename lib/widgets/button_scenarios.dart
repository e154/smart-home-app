import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ButtonScenarios extends StatefulWidget {
  Function function;
  String name;
  bool active;

  ButtonScenarios({Key key, this.function, this.name, this.active}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ButtonScenarios();
}

class _ButtonScenarios extends State<ButtonScenarios> {
  _ButtonScenarios();

  double _width = 120;
  double _height = 120;
  EdgeInsets _padding = EdgeInsets.all(5);

  _onTapDown(TapDownDetails details) {
    setState(() {
      _width = 110;
      _height = 110;
      _padding = EdgeInsets.all(10);
    });
  }

  _onTapCancel() {
    setState(() {
      _width = 120;
      _height = 120;
      _padding = EdgeInsets.all(5);
    });
  }

  _onTapUp(TapUpDetails details) {
    _onTapCancel();
    widget.function();
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
        onTapDown: _onTapDown,
        onTapCancel: _onTapCancel,
        onTapUp: _onTapUp,
        child: Container(
          constraints: BoxConstraints.expand(width: 130, height: 130),
          child: AnimatedContainer(
            duration: Duration(microseconds: 100000),
            reverseDuration: Duration(microseconds: 600),
            curve: Curves.easeInOut,
            padding: _padding,
            child: Container(
                decoration: new BoxDecoration(
                  color: widget.active ? Color.fromRGBO(43, 152, 240, 1) : Color.fromRGBO(234, 235, 235, 1),
                  borderRadius: new BorderRadius.all(const Radius.circular(12.0)),
//                boxShadow: [
//                  new BoxShadow(
//                    blurRadius: 3,
//                    color: active ? Colors.green : Colors.grey,
//                    spreadRadius: 0,
//                    offset: new Offset(3, 3),
//                  )
//                ],
                ),
                constraints: BoxConstraints.expand(width: _width, height: _height),
                child: Container(
                  padding: _padding,
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        widget.name,
                        style: TextStyle(
                            color: widget.active ? Colors.white : Color.fromRGBO(97, 97, 97, 1),
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  )),
                )),
          ),
        ));
    ;
  }
}
