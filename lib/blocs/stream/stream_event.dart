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

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:smart_home_app/models/dashboard_telemetry.dart';

@immutable
abstract class StreamEvent extends Equatable {
  StreamEvent([List props = const []]) : super(props);
}

class StreamEventInit extends StreamEvent {
  @override
  String toString() => 'StreamEventInit';
}

class StreamEventTelemetry extends StreamEvent {
  final DashboardTelemetry dashboardTelemetry;

  StreamEventTelemetry({@required this.dashboardTelemetry});

  @override
  String toString() => 'StreamEventTelemetry';
}

class StreamGetDevicesStates extends StreamEvent {
  StreamGetDevicesStates();

  @override
  String toString() => 'StreamGetDevicesStates';
}

class StreamGetWorkflowStates extends StreamEvent {
  StreamGetWorkflowStates();

  @override
  String toString() => 'StreamGetWorkflowStates';
}
