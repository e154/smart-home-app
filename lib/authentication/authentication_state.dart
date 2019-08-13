import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {}

//Un initialized (Не инициализирован)
class AuthenticationUninitialized extends AuthenticationState {
  @override
  String toString() => 'AuthenticationUninitialized';
}

//Authenticated (Авторозован)
class AuthenticationAuthenticated extends AuthenticationState {
  @override
  String toString() => 'AuthenticationAuthenticated';
}

//Unauthenticated (Не авторизован)
class AuthenticationUnauthenticated extends AuthenticationState {
  @override
  String toString() => 'AuthenticationUnauthenticated';
}

//NeedUpdateSettings
class NeedUpdateSettings extends AuthenticationState {
  @override
  String toString() => 'NeedUpdateSettings';
}

//Loading (Загрузка)
class AuthenticationLoading extends AuthenticationState {
  @override
  String toString() => 'AuthenticationLoading';
}
