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
