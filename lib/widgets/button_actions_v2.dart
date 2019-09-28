import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smart_home_app/models/models.dart';

class ButtonActionsV2 extends StatefulWidget {
  final MapDeviceAction action;
  final Function onPressed;

  ButtonActionsV2({Key key, this.action, this.onPressed}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ButtonActionsV2();
}

class _ButtonActionsV2 extends State<ButtonActionsV2> {
  double _padding = 5;
  double _squareScale = 1;

  _onTapDown(TapDownDetails details) {
    setState(() {
      _squareScale = 0.90;
    });
  }

  _onTapCancel() {
    setState(() {
      _squareScale = 1;
    });
  }

  _onTapUp(TapUpDetails details) {
    _onTapCancel();
    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapCancel: _onTapCancel,
      onTapUp: _onTapUp,
      child: AnimatedContainer(
        duration: Duration(seconds: 1),
        padding: EdgeInsets.all(_padding),
        child: Transform.scale(
          scale: _squareScale,
          child:
              (widget.action.image != null) ? widget.action.image.image : null,
        ),
      ),
    );
  }
}
