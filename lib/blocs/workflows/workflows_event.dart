import 'package:equatable/equatable.dart';

abstract class WorkflowsEvent extends Equatable {
  WorkflowsEvent([List props = const []]) : super(props);
}

class FetchWorkflowList extends WorkflowsEvent {
  @override
  String toString() => 'FetchWorkflowList';
}

