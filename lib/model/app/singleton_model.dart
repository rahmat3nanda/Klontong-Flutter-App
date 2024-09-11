/*
 * *
 *  * singleton_model.dart - klontong
 *  * Created by Rahmat Trinanda (rahmat3nanda@gmail.com) on 09/10/2024, 21:32
 *  * Copyright (c) 2024 . All rights reserved.
 *  * Last modified 07/13/2024, 21:22
 *
 */

import 'package:flutter/material.dart';
import 'package:klontong/model/category_model.dart';
import 'package:klontong/model/user_model.dart';

class SingletonModel {
  static SingletonModel? _singleton;

  factory SingletonModel() => _singleton ??= SingletonModel._internal();

  SingletonModel._internal();

  static SingletonModel withContext(BuildContext context) {
    _singleton ??= SingletonModel._internal();
    _singleton!.context = context;

    return _singleton!;
  }

  static SingletonModel get shared => _singleton ??= SingletonModel._internal();

  BuildContext? context;
  UserModel? user;
  bool? isLoggedIn;
  List<CategoryModel>? categories;

  void destroy() {
    _singleton = null;
  }
}