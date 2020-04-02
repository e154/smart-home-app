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
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:smart_home_app/models/dashboard_telemetry.dart';
import 'package:smart_home_app/models/map_telemetry.dart';
import 'package:smart_home_app/models/map_telemetry_device.dart';
import 'package:smart_home_app/models/telemetry_workflow.dart';
import 'package:smart_home_app/repositories/repository.dart';
import 'package:smart_home_app/repositories/server_stream/response.dart';
import 'stream_event.dart';
import 'stream_state.dart';

class StreamBloc extends Bloc<StreamEvent, StreamState> {
  final StreamController streamController = new StreamController.broadcast();

  StreamBloc() {
    Repository.get().stream.streamController.stream.listen(_streamListener);
  }

  @override
  void dispose() {
    super.dispose();
    streamController.close();
  }

  @override
  StreamState get initialState => StreamInitial();

  _streamListener(dynamic data) {
    if (data is Response) {
      if (data.payload is DashboardTelemetry) {
        streamController.sink.add(data.payload);
      }
      if (data.payload is MapTelemetry) {
        streamController.sink.add(data.payload);
      }
    }
  }

  @override
  Stream<StreamState> mapEventToState(StreamEvent event) async* {
    if (event is StreamGetDevicesStates) {
      final status = await Repository.get().stream.getDevicesStates();

      var devices = List<MapTelemetryDevice>();
      ((status as Response).payload['devices'] as List).forEach((v) {
        devices.add(MapTelemetryDevice.fromJson(v));
      });

      devices.forEach((device) {
        streamController.sink.add(MapTelemetry(device: device));
      });
      return;
    }
    if (event is StreamGetWorkflowStates) {
      final status = await Repository.get().stream.getWorkflowStates();

      if ((status as Response).payload['workflows'] == null) {
        return;
      }

      final workflow =
          TelemetryWorkflow.fromJson((status as Response).payload['workflows']);

      streamController.sink.add(DashboardTelemetry(workflow: workflow));

      return;
    }
  }
}
