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
    print('_onTapDown');
  }

  _onTapCancel() {
    print('_onTapCancel');
  }

  _onTapUp(TapUpDetails details) {
    print('_onTapUp');
    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapCancel: _onTapCancel,
      onTapUp: _onTapUp,
      behavior: HitTestBehavior.translucent,
      child: Container(
        key: UniqueKey(),
//        color: Colors.green,
        constraints: BoxConstraints.expand(width: 60, height: 60),
        child: AnimatedContainer(
          duration: Duration(seconds: 1),
          curve: Curves.easeInOut,
          padding: EdgeInsets.all(_padding),
          child: Transform.scale(
            scale: _squareScale,
            child: (widget.action.image != null)
                ? widget.action.image.image
                : null,
          ),
        ),
      ),
    );
  }
}
