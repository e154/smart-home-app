import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:smart_home_app/models/models.dart';

abstract class AuthenticationState extends Equatable {}

//Un initialized (Не инициализирован)
class AuthenticationUninitialized extends AuthenticationState {
  @override
  String toString() => 'AuthenticationUninitialized';
}

//Authenticated (Авторозован)
class AuthenticationAuthenticated extends AuthenticationState {
  User user;

  AuthenticationAuthenticated({@required this.user});

  @override
  String toString() => 'AuthenticationAuthenticated';
}

//Unauthenticated (Не авторизован)
class AuthenticationUnauthenticated extends AuthenticationState {
  @override
  String toString() => 'AuthenticationUnauthenticated';
}

//Loading (Загрузка)
class AuthenticationLoading extends AuthenticationState {
  @override
  String toString() => 'AuthenticationLoading';
}
