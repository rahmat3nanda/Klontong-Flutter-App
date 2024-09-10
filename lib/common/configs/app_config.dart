/*
 * *
 *  * app_config.dart - klontong
 *  * Created by Rahmat Trinanda (rahmat3nanda@gmail.com) on 09/10/2024, 19:38
 *  * Copyright (c) 2024 . All rights reserved.
 *  * Last modified 07/13/2024, 22:47
 *
 */

import 'package:klontong/model/app/app_version_model.dart';
import 'package:klontong/model/app/scheme_model.dart';

class AppConfig {
  static AppConfig? _config;

  factory AppConfig() => _config ??= AppConfig._internal();

  AppConfig._internal();

  static AppConfig get shared => _config ??= AppConfig._internal();

  late AppScheme scheme;
  late String baseUrlApi;
  late AppVersionModel version;
  late String? baseUrlImage;

  void initialize({
    required AppScheme scheme,
    required String baseUrlApi,
    required String baseUrlImage,
    required AppVersionModel version,
  }) {
    this.scheme = scheme;
    this.baseUrlApi = baseUrlApi;
    this.baseUrlImage = baseUrlImage;
    this.version = version;
  }
}
