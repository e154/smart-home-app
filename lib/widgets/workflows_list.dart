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
          print(state.workflowList);
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
