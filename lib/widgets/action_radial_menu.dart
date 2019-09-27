import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smart_home_app/models/models.dart';
import 'package:smart_home_app/widgets/button_actions_v2.dart';
import 'dart:math';
import 'package:vector_math/vector_math.dart' show radians, Vector3;
import 'package:flutter/material.dart';

class ActionRadialMenu {
  BuildContext context;
  List<MapDeviceAction> actions;
  OverlayEntry _overlayEntry;

  show({BuildContext context, List<MapDeviceAction> actions}) {
    this.context = context;
    this.actions = actions;
    _overlayEntry = _createOverlayEntry(actions);
    Overlay.of(context).insert(_overlayEntry);
  }

  OverlayEntry _createOverlayEntry(List<MapDeviceAction> actions) {
    RenderBox renderBox = context.findRenderObject();
    var size = renderBox.size;
    final position = renderBox.localToGlobal(Offset.zero);
//    print("POSITION of Red: $position");
//    print("SIZE of Red: $size");

    var left = position.dx + size.width / 2;
    var top = position.dy + size.height / 2;

    return OverlayEntry(
      builder: (context) {
        return Stack(children: [
          Positioned.fill(
//          child: new GestureDetector(
//            onTapUp: (_) {
//              print("_removeOverlay");
////            _removeOverlay();
//            },
//            behavior: HitTestBehavior.translucent,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: new Color.fromRGBO(0, 0, 0, 0.8),
            ),
//          ),
          ),
          _buildMenu(left, top, actions, 'left'),
        ]);
      },
    );
  }

  Widget _buildMenu(
      double left, top, List<MapDeviceAction> actions, String dir) {
    double i = -135;
    var children = actions.map((action) {
      i += 45;
      return _buildMenuButton(UniqueKey(), i, action, (action) {
        print('call action: ' + action.id.toString());
      });
    }).toList();

    return Positioned(
      left: left - 30,
      top: top - 30,
      child: Container(
//        color: Colors.indigo,
        child: Stack(
          children: children,
        ),
      ),
    );
  }

  Widget _buildMenuButton(Key key, double angle, MapDeviceAction action,
      Function(MapDeviceAction) onTapUp) {
    final double rad = radians(angle);

    var k = 100;
    return Transform.translate(
      offset: Offset(k * cos(rad), k * sin(rad)),
//      transform: Matrix4.identity()..translate(k * cos(rad), k * sin(rad)),
//      child: Container(
//        key: key,
//        color: Colors.amber,
//        width: 60,
//        height: 60,
        child: GestureDetector(
          onTapUp: (_){
            print("90");
          },
          child: FloatingActionButton(
              key: key,
              child: (action.image != null) ? action.image.image : null,
                backgroundColor: Colors.white,
              onPressed: () {
                print("onpressed");
              },
              elevation: 0),
        ),
//      ),
    );
  }

  _removeOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry.remove();
      _overlayEntry = null;
    }
  }
}
