/*
 * *
 *  * auth_bloc.dart - klontong
 *  * Created by Rahmat Trinanda (rahmat3nanda@gmail.com) on 09/11/2024, 13:28
 *  * Copyright (c) 2024 . All rights reserved.
 *  * Last modified 09/11/2024, 13:28
 *
 */

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klontong/bloc/auth/auth_event.dart';
import 'package:klontong/bloc/auth/auth_state.dart';
import 'package:klontong/common/constants.dart';
import 'package:klontong/model/app/singleton_model.dart';
import 'package:klontong/model/user_model.dart';
import 'package:klontong/tool/helper.dart';
import 'package:rcache_flutter/rcache.dart';

export 'package:klontong/bloc/auth/auth_event.dart';
export 'package:klontong/bloc/auth/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Helper _helper = Helper();

  AuthBloc(AuthInitialState super.initialState) {
    on<AuthLoadEvent>(_load);
    on<AuthLoginEvent>(_login);
    on<AuthLogoutEvent>(_logout);
  }

  void _load(AuthLoadEvent event, Emitter<AuthState> state) async {
    state(AuthInitialState());
    try {
      Map<String, dynamic>? map = await RCache.credentials.readMap(
        key: RCacheKey(AppString.data.user),
      );

      UserModel? user;
      if (map != null) {
        user = UserModel.fromJson(map);
      }

      SingletonModel.shared.user = user;
      SingletonModel.shared.isLoggedIn = user != null;

      state(const AuthLoadSuccessState());
    } catch (e) {
      SingletonModel.shared.user = null;
      SingletonModel.shared.isLoggedIn = false;
      state(
        AuthLoadFailedState(_helper.dioErrorHandler(e)),
      );
    }
  }

  void _login(AuthLoginEvent event, Emitter<AuthState> state) async {
    state(AuthInitialState());
    try {
      UserModel user = UserModel(
        username: event.username,
        password: event.password,
      );
      await RCache.credentials.saveMap(
        user.toJson(),
        key: RCacheKey(AppString.data.user),
      );

      SingletonModel.shared.user = user;
      SingletonModel.shared.isLoggedIn = true;

      state(const AuthLoginSuccessState());
    } catch (e) {
      SingletonModel.shared.isLoggedIn = false;
      state(
        AuthLoginFailedState(_helper.dioErrorHandler(e)),
      );
    }
  }

  void _logout(AuthLogoutEvent event, Emitter<AuthState> state) async {
    state(AuthInitialState());
    try {
      await RCache.credentials.remove(key: RCacheKey(AppString.data.user));
      _helper.destroySession();
      state(const AuthLogoutSuccessState());
    } catch (e) {
      _helper.destroySession();
      state(AuthLogoutFailedState(_helper.dioErrorHandler(e)));
    }
  }
}
