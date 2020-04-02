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
        duration: Duration(milliseconds: 300),
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
