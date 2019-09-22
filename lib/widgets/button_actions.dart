import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smart_home_app/models/models.dart';

class ButtonActions extends StatefulWidget {
  Function(BuildContext) onPressed;
  MapElement element;
  bool active;

  ButtonActions({Key key, this.onPressed, this.element, this.active})
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
  OverlayEntry _overlayEntry;

  _onTapDown(TapDownDetails details) {
    setState(() {
      _squareScale = 0.95;
    });
  }

  _onTapCancel() {
    setState(() {
      _squareScale = 1;
    });
  }

  _onTapUp(TapUpDetails details) {
    _onTapCancel();

    // show overlay
    var device = (widget.element.prototype as PrototypeDevice);
    if (device.actions.length > 0) {
      _overlayEntry = _createOverlayEntry(device.actions);
      Overlay.of(context).insert(_overlayEntry);

//      Future.delayed(const Duration(seconds: 4), () {
//        _removeOverlay();
//      });
    }

    // callback
    widget.onPressed(context);
  }

  void _removeOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry.remove();
      _overlayEntry = null;
    }
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
              constraints:
                  BoxConstraints.expand(width: _width, height: _height),
              child: Container(
                padding: EdgeInsets.all(_padding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 60,
                      height: 60,
                      child: (widget.element.prototypeType == 'device')
                          ? (widget.element.prototype as PrototypeDevice)
                              .serverImage
                              .image
                          : null,
                    ),
                    Container(
                      height: 20,
                    ),
                    Container(
                      height: 30,
                      child: Text(
                        widget.element.description,
                        style: TextStyle(
                            color: widget.active
                                ? Colors.white
                                : Color.fromRGBO(97, 97, 97, 1),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
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
        return Positioned.fill(
            child: GestureDetector(
          onTapUp: (_) {
            _removeOverlay();
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: new Color.fromRGBO(0, 0, 0, 0.8),
            child: _buildMenu(left, top, actions, 'left'),
          ),
        ));
      },
    );
  }

  Widget _buildMenuButton(
      MapDeviceAction action, Function(MapDeviceAction) onTapUp) {
    return new GestureDetector(
      onTapUp: (_) {
        _removeOverlay();
        onTapUp(action);
      },
      child: Container(
//        color: Colors.amber,
        width: 60,
        height: 60,
        child: (action.image != null) ? action.image.image : null,
      ),
    );
  }

  Widget _buildMenu(
      double left, top, List<MapDeviceAction> actions, String dir) {
    var children = actions
        .map((action) => _buildMenuButton(action, (action) {
              print('call action: ' + action.id.toString());
            }))
        .toList();
    return Container(
      alignment: Alignment(-1, -1),
//      color: Colors.indigo,

      margin: EdgeInsets.only(top: top, left: left),
      child: Column(
        children: children,
      ),
    );
  }
}
