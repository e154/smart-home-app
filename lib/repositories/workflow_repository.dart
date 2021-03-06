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

import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:smart_home_app/models/models.dart';
import 'requests/workflow_update_scenario.dart';

class WorkflowRepository {
  Client httpClient;

  WorkflowRepository({@required this.httpClient}) : assert(httpClient != null);

  Future<List<WorkflowShort>> fetchList(
      int limit, offset, String order, sortBy) async {
    try {
      final response = await this
          .httpClient
          .get(
              '/workflows?limit=$limit&offset=$offset&order=$order&sort_by=$sortBy')
          .timeout(const Duration(seconds: 1));
      switch (response.statusCode) {
        case 200:
          final workflowList = (jsonDecode(response.body)["items"] as List)
              .map((f) => WorkflowShort.fromJson(f))
              .toList();
          return workflowList;
          break;
        default:
          throw Exception('error fetch workflow list: ' + response.body);
      }
    } catch (error) {
      return null;
    }
  }

  Future<Workflow> getById(int id) async {
    try {
      final response = await this
          .httpClient
          .get('/workflow/$id')
          .timeout(const Duration(seconds: 1));
      switch (response.statusCode) {
        case 200:
          final workflow = Workflow.fromJson(jsonDecode(response.body));
          return workflow;
          break;
        default:
          throw Exception('error fetch workflow by id: ' + response.body);
      }
    } catch (error) {
      return null;
    }
  }

  Future<List<WorkflowScenario>> fetchScenariosList(int workflowId) async {
    try {
      final response = await this
          .httpClient
          .get('/workflow/$workflowId/scenarios')
          .timeout(const Duration(seconds: 1));
      switch (response.statusCode) {
        case 200:
          final workflowScenarios = (jsonDecode(response.body)["items"] as List)
              .map((f) => WorkflowScenario.fromJson(f))
              .toList();
          return workflowScenarios;
          break;
        default:
          throw Exception('error fetchScenariosList: ' + response.body);
      }
    } catch (error) {
      return null;
    }
  }

  Future<void> updateScenario(int workflowId, scenarioId) async {
    try {
      final body = WorkflowUpdateScenario(workflowScenarioId: scenarioId);
      final response = await this
          .httpClient
          .put('/workflow/$workflowId/update_scenario', body: workflowUpdateScenarioToJson(body))
          .timeout(const Duration(seconds: 1));
      switch (response.statusCode) {
        case 200:
          break;
        default:
          throw Exception('error updateScenario: ' + response.body);
      }
    } catch (error) {
      return null;
    }
  }
}
