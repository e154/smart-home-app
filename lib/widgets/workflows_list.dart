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

class WorkflowsList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WorkflowsListState();
}

class _WorkflowsListState extends State<WorkflowsList> {
  List<WorkflowShort> workflowList;
  Completer<void> _refreshCompleter;

  @override
  Widget build(BuildContext context) {
    final settingsBloc = BlocProvider.of<WorkflowsBloc>(context);
    settingsBloc.dispatch(FetchWorkflowList());

    return BlocListener<WorkflowsBloc, WorkflowsState>(
      listener: (context, state) {
        if (state is WorkflowListLoaded) {
          workflowList = state.workflowList;
          _refreshCompleter?.complete();
          _refreshCompleter = Completer();
        }
        if (state is WorkflowsFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<WorkflowsBloc, WorkflowsState>(builder: (context, state) {
        Widget _child() {
          if (ListView == null) {
            return Container(
              child: Center(
                child: Text("No workflow"),
              ),
            );
          }

          if (workflowList == null) {
            return Container(
              child: Center(
                child: Text("No data"),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: workflowList.length,
              padding: const EdgeInsets.all(6),
              itemBuilder: (BuildContext context, int i) {
                return _buildRow(workflowList[i]);
              },
            );
          }
        }

//        return Container(
//          child: Center(
//            child: CircularProgressIndicator(),
//          ),
//        );
        return RefreshIndicator(
          onRefresh: () {
            settingsBloc.dispatch(FetchWorkflowList());
            return _refreshCompleter.future;
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text('Workflow list'),
            ),
            body: _child(),
          ),
        );
      }),
    );
  }

  Widget _buildRow(WorkflowShort wf) {
    return ListTile(
      title: Text(wf.name),
      subtitle: Text(wf.description),
      onTap: () {
        Navigator.pop(context, wf);
      },
    );
  }
}
