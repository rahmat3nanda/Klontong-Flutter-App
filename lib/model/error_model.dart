/*
 * *
 *  * error_model.dart - klontong
 *  * Created by Rahmat Trinanda (rahmat3nanda@gmail.com) on 09/12/2024, 13:37
 *  * Copyright (c) 2024 . All rights reserved.
 *  * Last modified 09/12/2024, 13:37
 *
 */

import 'package:equatable/equatable.dart';

class ErrorModel {
  Equatable event;
  String error;

  ErrorModel({required this.event, required this.error});
}
