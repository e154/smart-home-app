/*
 * This file is part of the Smart Home
 * Program complex distribution https://github.com/e154/smart-home-app
 * Copyright (C) 2016-2020, Filippov Alex
 *
 * This library is free software: you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 3 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Library General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library.  If not, see
 * <https://www.gnu.org/licenses/>.
 */

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

//  double _width = 120;
//  double _height = 120;
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

      widgetDevice.states.forEach((state){
        if (widgetDevice.deviceId == device.id && state.deviceStateId == device.statusId) {
//          print("SET STATE: " + state.systemName);
          setState(() {
            _currentState = state;
            widget.active = state.systemName.contains('_ON');
          });
          return;
        }
      });
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
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
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
//                    constraints:
//                        BoxConstraints.expand(width: _width, height: _height),
                    child: Container(
                      padding: EdgeInsets.all(_padding),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Expanded(
                            flex: 4,
                            child: Container(
                              child: (widget.element.prototypeType == 'device' && _currentState == null)
                                  ? (widget.element.prototype as PrototypeDevice)
                                  .serverImage
                                  .image
                                  : _currentState.image.image,
                            )
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(),
                          ),
                          Expanded(
                            flex: 4,
                            child: Container(
                              child: Text(
                                widget.element.description,
                                style: TextStyle(
                                    color: widget.active
                                        ? Colors.white
                                        : Color.fromRGBO(97, 97, 97, 1),
                                    fontWeight: FontWeight.bold),
                              ),
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
