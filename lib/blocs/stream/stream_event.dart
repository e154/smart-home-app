import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class StreamEvent extends Equatable {
  StreamEvent([List props = const []]) : super(props);
}

