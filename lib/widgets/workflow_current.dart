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