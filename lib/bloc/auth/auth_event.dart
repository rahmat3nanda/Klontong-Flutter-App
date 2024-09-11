/*
 * *
 *  * auth_event.dart - klontong
 *  * Created by Rahmat Trinanda (rahmat3nanda@gmail.com) on 09/11/2024, 13:27
 *  * Copyright (c) 2024 . All rights reserved.
 *  * Last modified 09/11/2024, 13:27
 *
 */

import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthLoadEvent extends AuthEvent {
  const AuthLoadEvent();

  @override
  String toString() {
    return "AuthLoadEvent{}";
  }
}

class AuthLoginEvent extends AuthEvent {
  final String username;
  final String password;

  const AuthLoginEvent({required this.username, required this.password});

  @override
  String toString() {
    return "AuthLoginEvent{username: $username, password: $password}";
  }
}

class AuthLogoutEvent extends AuthEvent {
  const AuthLogoutEvent();

  @override
  String toString() {
    return "AuthLogoutEvent{}";
  }
}
