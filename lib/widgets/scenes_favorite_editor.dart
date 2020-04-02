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

class SceneFavoriteEditor extends StatefulWidget {
  final List<int> favorite;
  final Workflow workflow;

  const SceneFavoriteEditor({Key key, this.favorite, this.workflow}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SceneFavoriteEditor();
}

class _SceneFavoriteEditor extends State<SceneFavoriteEditor> {
  @override
  Widget build(BuildContext context) {
    final _appbar = AppBar(
      title: Text('Scenarios'),
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context, widget.favorite),
      ),
    );
    List<Widget> _child() {
      return widget.workflow.scenarios.map((scenario) {
        return CheckboxListTile(
          key: Key(scenario.name),
          value: widget.favorite == null ? false : widget.favorite.contains(scenario.id),
          title: Text(scenario.name, style: TextStyle(fontWeight: FontWeight.bold),),
          onChanged: (bool newVal) {
            if (newVal) {
              widget.favorite.add(scenario.id);
            } else {
              widget.favorite.remove(scenario.id);
            }
            setState(() {

            });
          },
        );
      }).toList();
    }

    return Scaffold(
        appBar: _appbar,
        body: ListView(
          children: _child(),
        ));
  }
}
