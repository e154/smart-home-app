import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:smart_home_app/models/models.dart';

abstract class StreamState extends Equatable {
  StreamState([List props = const []]) : super(props);
}

class StreamInitial extends StreamState {
  @override
  String toString() => 'StreamInitial';
}

class StreamDevices extends StreamState {
  List<TelemetryDevice> devices;

  StreamDevices({@required this.devices});

  @override
  String toString() => 'StreamDevices';
}
