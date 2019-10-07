import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:smart_home_app/repositories/repository.dart';

import 'workflows_event.dart';
import 'workflows_state.dart';

class WorkflowsBloc extends Bloc<WorkflowsEvent, WorkflowsState> {
  WorkflowsBloc();

  @override
  WorkflowsState get initialState => WorkflowsInitial();

  @override
  Stream<WorkflowsState> mapEventToState(WorkflowsEvent event) async* {
    if (event is FetchWorkflowList) {
      try {
        yield LoadWorkflowList();
        final workflowList =
            await Repository.get().workflow.fetchList(30, 0, "DESC", "id");
        yield WorkflowListLoaded(workflowList);
      } catch (error) {
        yield WorkflowsFailure(error: error.toString());
      }
    }
  }
}
