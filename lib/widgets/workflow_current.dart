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

import 'workflows_list.dart';

class WorkflowCurrent extends StatefulWidget {
  final Workflow currentWorkflow;

  WorkflowCurrent(this.currentWorkflow);

  @override
  State<WorkflowCurrent> createState() => _WorkflowCurrentState();
}

class _WorkflowCurrentState extends State<WorkflowCurrent> {

  @override
  Widget build(BuildContext context) {
//    if (currentWorkflow == null) {
//      return FlatButton(
//        child: Text("workflow not selected"),
//        onPressed: () => _selectFrom(context),
//      );
//    }
    return ListTile(
//      title: Text(currentWorkflow.name),
//      subtitle: Text(currentWorkflow.description),
//      onTap: () => _selectFrom(context),
    );
  }

  _selectFrom(context) async {
    final workflow = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WorkflowsList(),
      ),
    );
    if (workflow != null) {
      print('workflow ' + workflow.toString());
//      weatherBloc.dispatch(FetchWeather(city: city));
    }
  }
}