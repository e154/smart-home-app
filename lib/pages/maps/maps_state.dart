import 'package:equatable/equatable.dart';

abstract class MapsState extends Equatable {
  MapsState([List props = const []]) : super(props);
}

class MapsInitial extends MapsState {
  @override
  String toString() => 'MapsInitial';
}
