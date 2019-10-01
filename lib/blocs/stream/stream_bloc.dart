import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:smart_home_app/models/dashboard_telemetry.dart';
import 'package:smart_home_app/repositories/repository.dart';
import 'package:smart_home_app/repositories/server_stream/request.dart';
import 'package:smart_home_app/repositories/server_stream/response.dart';
import 'stream_event.dart';
import 'stream_state.dart';

class StreamBloc extends Bloc<StreamEvent, StreamState> {
  StreamBloc() {
    Repository.get().stream.streamController.stream.listen(_streamListener);
  }

  @override
  StreamState get initialState => StreamInitial();

  _streamListener(dynamic data) {
    if (data is Response) {
      final payload = data.payload;
     if (payload is DashboardTelemetry) {
       print(payload.device);
     }
    }
  }

  @override
  Stream<StreamState> mapEventToState(StreamEvent event) async* {

  }
}
