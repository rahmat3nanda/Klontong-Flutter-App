/*
 * *
 *  * auth_state.dart - klontong
 *  * Created by Rahmat Trinanda (rahmat3nanda@gmail.com) on 09/11/2024, 13:27
 *  * Copyright (c) 2024 . All rights reserved.
 *  * Last modified 09/11/2024, 13:27
 *
 */

import 'package:equatable/equatable.dart';
import 'package:klontong/model/response_model.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitialState extends AuthState {}

class AuthLoadSuccessState extends AuthState {
  const AuthLoadSuccessState();
}

class AuthLoadFailedState extends AuthState {
  final ResponseModel data;

  const AuthLoadFailedState(this.data);
}

class AuthLoginSuccessState extends AuthState {
  const AuthLoginSuccessState();
}

class AuthLoginFailedState extends AuthState {
  final ResponseModel data;

  const AuthLoginFailedState(this.data);
}

class AuthLogoutSuccessState extends AuthState {
  const AuthLogoutSuccessState();
}

class AuthLogoutFailedState extends AuthState {
  final ResponseModel data;

  const AuthLogoutFailedState(this.data);
}
