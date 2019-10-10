import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:smart_home_app/models/models.dart';

abstract class HomeEvent extends Equatable {
  HomeEvent([List props = const []]) : super(props);
}

class HomeFetchSettings extends HomeEvent {
  @override
  String toString() => 'HomeFetchSettings';
}

class HomeFetchWorkflow extends HomeEvent {
  @override
  String toString() => 'HomeFetchWorkflow';
}

class HomeUpdateFavoriteScenarioList extends HomeEvent {
  final List<int> scenarios;

  HomeUpdateFavoriteScenarioList(this.scenarios);

  @override
  String toString() => 'HomeUpdateFavoriteScenarioList';
}

class HomeUpdateFavoriteActionList extends HomeEvent {
  final List<int> actions;

  HomeUpdateFavoriteActionList(this.actions);

  @override
  String toString() => 'HomeUpdateFavoriteActionList';
}

class HomeSelectWorkflow extends HomeEvent {
  WorkflowShort _workflow;

  HomeSelectWorkflow(this._workflow);

  WorkflowShort get workflow => _workflow;

  @override
  String toString() => 'HomeSelectWorkflow';
}

class HomeDoAction extends HomeEvent {
  final MapDeviceAction action;

  HomeDoAction({@required this.action});

  @override
  String toString() => 'HomeDoAction';
}

class HomeSelectScenario extends HomeEvent {
  final int workflowId, scenarioId;

  HomeSelectScenario({@required this.workflowId, this.scenarioId});

  @override
  String toString() => 'HomeSelectScenario';
}
