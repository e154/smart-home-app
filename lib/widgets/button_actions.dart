import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smart_home_app/models/models.dart';

class ButtonActions extends StatefulWidget {
  Function function;
  MapElement element;
  bool active;

  ButtonActions({Key key, this.function, this.element, this.active})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ButtonScenarios();
}

class _ButtonScenarios extends State<ButtonActions> {
  _ButtonScenarios();

  double _width = 120;
  double _height = 120;
  double _padding = 5;
  double _squareScale = 1;

  _onTapDown(TapDownDetails details) {
    setState(() {
//      _width = 110;
//      _height = 110;
//      _padding = 10;
      _squareScale = 0.95;
    });
  }

  _onTapCancel() {
    setState(() {
//      _width = 120;
//      _height = 120;
//      _padding = 5;
      _squareScale = 1;
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
            duration: Duration(seconds: 1),
            curve: Curves.easeInOut,
            padding: EdgeInsets.all(_padding),
            child: Transform.scale(
              scale: _squareScale,
              child: Container(
                  decoration: new BoxDecoration(
                    color: widget.active
                        ? Color.fromRGBO(43, 152, 240, 1)
                        : Color.fromRGBO(234, 235, 235, 1),
                    borderRadius:
                        new BorderRadius.all(const Radius.circular(12.0)),
//                boxShadow: [
//                  new BoxShadow(
//                    blurRadius: 3,
//                    color: active ? Colors.green : Colors.grey,
//                    spreadRadius: 0,
//                    offset: new Offset(3, 3),
//                  )
//                ],
                  ),
                  constraints:
                      BoxConstraints.expand(width: _width, height: _height),
                  child: Container(
                    padding: EdgeInsets.all(_padding),
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            width: 60,
                            height: 60,
                            child: (widget.element.prototypeType == 'device')
                                ? (widget.element.prototype as PrototypeDevice)
                                    .serverImage
                                    .image
                                : null),
                        Text(
                          widget.element.description,
                          style: TextStyle(
                              color: widget.active
                                  ? Colors.white
                                  : Color.fromRGBO(97, 97, 97, 1),
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),
                  )),
            ),
          ),
        ));
    ;
  }
}
