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
