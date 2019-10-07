import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:smart_home_app/models/models.dart';

abstract class WorkflowsState extends Equatable {
  WorkflowsState([List props = const []]) : super(props);
}

class WorkflowsInitial extends WorkflowsState {
  @override
  String toString() => 'WorkflowsInitial';
}

class LoadWorkflowList extends WorkflowsState {
  @override
  String toString() => 'LoadWorkflowList';
}

class WorkflowListLoaded extends WorkflowsState {
  List<WorkflowShort> workflowList;

  WorkflowListLoaded(this.workflowList) {
    if (workflowList == null) {
      workflowList = List<WorkflowShort>();
    }
  }

  @override
  String toString() => 'WorkflowListLoaded';
}

class WorkflowsFailure extends WorkflowsState {
  final String error;

  WorkflowsFailure({@required this.error}) : super([error]);

  @override
  String toString() => 'WorkflowsFailure { error: $error }';
}
