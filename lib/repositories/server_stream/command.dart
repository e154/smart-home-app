import 'package:equatable/equatable.dart';

abstract class Command extends Equatable {
  Command([List props = const []]) : super(props);
  Map<String, dynamic> toJson();
  String command();
}
