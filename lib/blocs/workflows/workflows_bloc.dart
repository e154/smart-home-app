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
