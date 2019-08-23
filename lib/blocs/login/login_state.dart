import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_home_app/models/models.dart';

abstract class LoginState extends Equatable {
  LoginState([List props = const []]) : super(props);
}

class LoginInitial extends LoginState {
  @override
  String toString() => 'LoginInitial';
}

class LoginLoading extends LoginState {
  @override
  String toString() => 'LoginLoading';
}

class LoginLoadSettings extends LoginState {
  @override
  String toString() => 'LoginLoadSettings';
}

class LoginSettingsLoaded extends LoginState {
  Settings settings;
  Credentials credentials;

  LoginSettingsLoaded(this.settings, this.credentials);

  @override
  String toString() => 'LoginSettingsLoaded';
}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure({@required this.error}) : super([error]);

  @override
  String toString() => 'LoginFailure { error: $error }';
}
