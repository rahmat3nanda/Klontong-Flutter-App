/*
 * *
 *  * auth_page.dart - klontong
 *  * Created by Rahmat Trinanda (rahmat3nanda@gmail.com) on 09/12/2024, 17:52
 *  * Copyright (c) 2024 . All rights reserved.
 *  * Last modified 09/12/2024, 17:52
 *
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:klontong/bloc/auth/auth_bloc.dart';
import 'package:klontong/common/constants.dart';
import 'package:klontong/common/styles.dart';
import 'package:klontong/model/app/singleton_model.dart';
import 'package:klontong/tool/helper.dart';
import 'package:klontong/widget/button_widget.dart';
import 'package:klontong/widget/loading_overlay.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  late Helper _helper;
  late AuthBloc _bloc;

  late GlobalKey<FormState> _formKey;
  late TextEditingController _cUsername;
  late TextEditingController _cPassword;
  late bool _obscure;
  late bool _isLoading;

  @override
  void initState() {
    super.initState();
    SingletonModel.withContext(context);
    _helper = Helper();
    _bloc = BlocProvider.of<AuthBloc>(context);
    _formKey = GlobalKey();
    _cUsername = TextEditingController();
    _cPassword = TextEditingController();
    _obscure = true;
    _isLoading = false;
  }

  void _onAuth() async {
    FocusScope.of(context).unfocus();

    if (_cUsername.text.trim().isEmpty) {
      _helper.showToast("Username cannot be empty!");
      return;
    }

    if (_cPassword.text.trim().isEmpty) {
      _helper.showToast("Password cannot be empty!");
      return;
    }

    if (_formKey.currentState?.validate() ?? false) {
      _isLoading = true;
      _bloc.add(AuthLoginEvent(
        username: _cUsername.text.trim(),
        password: _cPassword.text.trim(),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _bloc,
      listener: (c, s) async {
        if (s is AuthLoginSuccessState) {
          _isLoading = false;
          _helper.showToast("Success Sign in");
          await Future.delayed(const Duration(seconds: 1));
          Navigator.pop(context);
        } else if (s is AuthLoginFailedState) {
          _isLoading = false;
          _helper.showToast("Failure Sign in");
        }
      },
      child: BlocBuilder(
        bloc: _bloc,
        builder: (c, s) {
          return LoadingOverlay(
            isLoading: _isLoading,
            color: Colors.white,
            progressIndicator: SpinKitWaveSpinner(
              color: AppColor.primaryLight,
              trackColor: AppColor.primary,
              waveColor: AppColor.secondary,
              size: 64,
            ),
            child: Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ),
              body: SafeArea(child: _mainView()),
            ),
          );
        },
      ),
    );
  }

  Widget _mainView() {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AppIcon.klontong,
                width: 64,
              ),
              const SizedBox(width: 12),
              Column(
                children: [
                  Text(
                    "Klontong",
                    style: TextStyle(
                      color: AppColor.primaryLight,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "Find your needs",
                    style: GoogleFonts.parisienne(fontSize: 16),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned.fill(
          top: -64,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Sign in",
                style: TextStyle(
                  color: AppColor.primaryLight,
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: MediaQuery.of(context).size.width * .8,
                child: _formView(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _formView() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            maxLines: 1,
            textInputAction: TextInputAction.next,
            controller: _cUsername,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(hintText: "Username"),
          ),
          const SizedBox(height: 12),
          TextFormField(
            maxLines: 1,
            textInputAction: TextInputAction.done,
            controller: _cPassword,
            keyboardType: TextInputType.text,
            obscureText: _obscure,
            decoration: InputDecoration(
              hintText: "Kata Sandi",
              suffixIcon: IconButton(
                icon: Icon(
                  _obscure ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () => setState(() {
                  _obscure = !_obscure;
                }),
              ),
            ),
          ),
          const SizedBox(height: 22),
          ButtonWidget(
            onTap: _onAuth,
            width: double.infinity,
            withShadow: false,
            child: const Text(
              "Login",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
