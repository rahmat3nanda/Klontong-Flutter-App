/*
 * *
 *  * main.dart - klontong
 *  * Created by Rahmat Trinanda (rahmat3nanda@gmail.com) on 09/11/2024, 13:26
 *  * Copyright (c) 2024 . All rights reserved.
 *  * Last modified 09/11/2024, 13:26
 *
 */

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klontong/app.dart';
import 'package:klontong/bloc/observer.dart';
import 'package:klontong/common/configs.dart';
import 'package:klontong/common/constants.dart';
import 'package:klontong/model/app/app_version_model.dart';
import 'package:klontong/model/app/scheme_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterError.onError = (errorDetails) {
    // can be sent to crashlytics
    AppLog.print(errorDetails);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    // can be sent to crashlytics
    AppLog.print(error);
    return true;
  };
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  AppLog.debugMode = false;

  // Your endpoint from crudcrud.com
  String endpoint = "33ada9ac9612458795735305f495f281";
  AppConfig.shared.initialize(
    scheme: AppScheme.prod,
    baseUrlApi: "https://crudcrud.com/api/$endpoint/",
    version: AppVersionModel.empty(),
  );

  Bloc.observer = Observer();
  runApp(const App());
}
