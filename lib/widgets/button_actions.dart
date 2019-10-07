import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home_app/blocs/blocs.dart';
import 'package:smart_home_app/models/models.dart';

class ButtonActions extends StatefulWidget {
  Function(BuildContext, List<MapDeviceAction>) onPressed;
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
  StreamSubscription streamBlocListener;
  MapDeviceState _currentState;

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
    var device = (widget.element.prototype as PrototypeDevice);
    widget.onPressed(context, device.actions);
  }

  _streamListener(dynamic data) {
    if (data is MapTelemetry) {
      final device = data.device;
      var widgetDevice = (widget.element.prototype as PrototypeDevice);

      if (widget.element.name == device.elementName) {
        widgetDevice.states.forEach((state){
          if (state.systemName == device.status.systemName) {
//            print("SET STATE: " + state.systemName);
            setState(() {
              _currentState = state;
            });
          }
        });
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    streamBlocListener.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final streamBloc = BlocProvider.of<StreamBloc>(context);
    if (streamBlocListener == null) {
      streamBlocListener =
          streamBloc.streamController.stream.listen(_streamListener);
    }

    return BlocListener<StreamBloc, StreamState>(
        listener: (context, state) {},
        child: BlocBuilder<StreamBloc, StreamState>(builder: (context, state) {
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 60,
                            height: 60,
                            child: (widget.element.prototypeType == 'device' && _currentState == null)
                                ? (widget.element.prototype as PrototypeDevice)
                                    .serverImage
                                    .image
                                : _currentState.image.image,
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
        }));
  }
}
