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
import 'package:smart_home_app/widgets/button_actions_v2.dart';

class ActionVerticalMenu {
  BuildContext context;
  List<MapDeviceAction> actions;
  OverlayEntry _overlayEntry;
  Function _onPressed;

  ActionVerticalMenu(Function onPressed) {
    this._onPressed = onPressed;
  }

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
            child: new GestureDetector(
              onTapUp: (_) {
//                print("_removeOverlay");
                _removeOverlay();
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: new Color.fromRGBO(0, 0, 0, 0.8),
                child: Center(
                  child: _buildMenu(left, top, actions, 'left'),
                ),
              ),
            ),
          ),
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }

  Widget _buildMenuButton(Key key, double angle, MapDeviceAction action,
      Function(MapDeviceAction) onTapUp) {
    return Container(
        constraints: BoxConstraints.expand(width: 100, height: 100),
        child: ButtonActionsV2(
            action: action,
            onPressed: () {
              _removeOverlay();
              _onPressed(action);
            }));
  }

  _removeOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry.remove();
      _overlayEntry = null;
    }
  }
}
