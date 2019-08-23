import 'package:equatable/equatable.dart';

abstract class MapsEvent extends Equatable {
  MapsEvent([List props = const []]) : super(props);
}

class FetchMapList extends MapsEvent {
  @override
  String toString() => 'FetchMapList';
}

