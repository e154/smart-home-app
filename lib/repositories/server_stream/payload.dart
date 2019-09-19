import 'package:equatable/equatable.dart';

abstract class Payload extends Equatable {
  Payload([List props = const []]) : super(props);
  Map<String, dynamic> toJson();
}
