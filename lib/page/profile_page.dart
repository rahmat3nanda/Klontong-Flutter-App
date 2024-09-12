/*
 * *
 *  * profile_page.dart - klontong
 *  * Created by Rahmat Trinanda (rahmat3nanda@gmail.com) on 09/12/2024, 18:22
 *  * Copyright (c) 2024 . All rights reserved.
 *  * Last modified 09/12/2024, 18:22
 *
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klontong/bloc/auth/auth_bloc.dart';
import 'package:klontong/common/styles/app_color.dart';
import 'package:klontong/dialog/app_alert_dialog.dart';
import 'package:klontong/model/app/button_action_model.dart';
import 'package:klontong/model/app/singleton_model.dart';
import 'package:klontong/page/auth_page.dart';
import 'package:klontong/tool/helper.dart';
import 'package:klontong/widget/app_bar_widget.dart';
import 'package:klontong/widget/button_widget.dart';

class ProfilePage extends StatefulWidget {
  final Function(bool isLoading) showLoading;

  const ProfilePage({super.key, required this.showLoading});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late SingletonModel _model;
  late Helper _helper;
  late AuthBloc _bloc;

  @override
  void initState() {
    super.initState();
    _model = SingletonModel.withContext(context);
    _helper = Helper();
    _bloc = BlocProvider.of<AuthBloc>(context);
  }

  void _onAction() async {
    if (_model.isLoggedIn == true) {
      _logout();
      return;
    }

    await _helper.jumpToPage(context, page: const AuthPage());
    _model = SingletonModel.withContext(context);
  }

  void _logout() async {
    bool? logout = await openAppAlertDialog(
      context,
      title: "Logout",
      message: "Are you sure you want to logout?",
      actions: [
        ButtonActionModel(
          child: const Text("No"),
          onTap: (c) => Navigator.pop(c, false),
        ),
        ButtonActionModel(
          child: const Text(
            "Yes",
            style: TextStyle(color: Colors.red),
          ),
          onTap: (c) => Navigator.pop(c, true),
        ),
      ],
    );

    if (logout == true) {
      widget.showLoading(true);
      _bloc.add(const AuthLogoutEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    _model = SingletonModel.withContext(context);
    return BlocListener(
      bloc: _bloc,
      listener: (c, s) {
        if (s is AuthLogoutSuccessState) {
          widget.showLoading(false);
          _model = SingletonModel.withContext(context);
          _helper.showToast("Success Logout");
        } else if (s is AuthLoginFailedState) {
          widget.showLoading(false);
          _model = SingletonModel.withContext(context);
          _helper.showToast("Failure Logout");
        }
      },
      child: BlocBuilder(
        bloc: _bloc,
        builder: (c, s) {
          return Scaffold(
            appBar: const AppBarWidget(subtitle: "Profile"),
            body: Center(child: _mainView()),
          );
        },
      ),
    );
  }

  Widget _mainView() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (_model.isLoggedIn == true)
          Text(SingletonModel.shared.user?.username ?? ""),
        if (_model.isLoggedIn == true) const SizedBox(height: 16),
        ButtonWidget(
          onTap: _onAction,
          withShadow: false,
          color: _model.isLoggedIn == true ? Colors.red : AppColor.primary,
          child: Text(
            _model.isLoggedIn == true ? "Logout" : "Login",
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
