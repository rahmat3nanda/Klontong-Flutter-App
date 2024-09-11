/*
 * *
 *  * splash_page.dart - klontong
 *  * Created by Rahmat Trinanda (rahmat3nanda@gmail.com) on 09/10/2024, 21:16
 *  * Copyright (c) 2024 . All rights reserved.
 *  * Last modified 09/10/2024, 21:16
 *
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:klontong/bloc/auth/auth_bloc.dart';
import 'package:klontong/common/constants.dart';
import 'package:klontong/common/styles.dart';
import 'package:klontong/model/app/singleton_model.dart';
import 'package:klontong/page/main_page.dart';
import 'package:klontong/tool/helper.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AuthBloc _bloc;
  late Helper _helper;

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    SingletonModel.withContext(context);
    _bloc = BlocProvider.of<AuthBloc>(context);
    _helper = Helper();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _setup();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _setup() async {
    await _controller.forward();
    _bloc.add(const AuthLoadEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _bloc,
      listener: (c, s) {
        if (s is AuthLoadSuccessState) {
          _helper.moveToPage(context, page: const MainPage());
        } else if (s is AuthLoadFailedState) {
          _helper.moveToPage(context, page: const MainPage());
        }
      },
      child: BlocBuilder(
        bloc: _bloc,
        builder: (c, s) {
          return Scaffold(
            body: FadeTransition(
              opacity: CurvedAnimation(
                parent: _controller,
                curve: Curves.easeOut,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Transform.translate(
                    offset: const Offset(-12, 0),
                    child: SvgPicture.asset(
                      AppIcon.klontong,
                      width: 152,
                    ),
                  ),
                  const SizedBox(height: 24, width: double.infinity),
                  Text(
                    "Klontong",
                    style: TextStyle(
                      color: AppColor.primaryLight,
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Find your needs",
                    style: GoogleFonts.parisienne(fontSize: 24),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
