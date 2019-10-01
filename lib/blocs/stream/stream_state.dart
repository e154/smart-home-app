import 'package:equatable/equatable.dart';

abstract class StreamState extends Equatable {
  StreamState([List props = const []]) : super(props);
}

class StreamInitial extends StreamState {
  @override
  String toString() => 'StreamInitial';
}
