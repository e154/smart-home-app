import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:smart_home_app/repositories/repository.dart';
import 'stream_event.dart';
import 'stream_state.dart';

class StreamBloc extends Bloc<StreamEvent, StreamState> {
  StreamBloc();

  @override
  StreamState get initialState => StreamInitial();

  @override
  Stream<StreamState> mapEventToState(StreamEvent event) async* {

  }
}
