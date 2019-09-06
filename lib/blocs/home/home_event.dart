import 'package:equatable/equatable.dart';
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

class HomeSelectWorkflow extends HomeEvent {
  WorkflowShort _workflow;

  HomeSelectWorkflow(this._workflow);

  WorkflowShort get workflow => _workflow;

  @override
  String toString() => 'HomeSelectWorkflow';
}
