/*
 * *
 *  * response_model.dart - klontong
 *  * Created by Rahmat Trinanda (rahmat3nanda@gmail.com) on 09/10/2024, 21:34
 *  * Copyright (c) 2024 . All rights reserved.
 *  * Last modified 07/13/2024, 18:28
 *
 */

import 'dart:convert';

class ResponseModel {
  ResponseModel({
    this.code,
    this.success,
    this.message,
    this.data,
  });

  int? code;
  final bool? success;
  dynamic message;
  dynamic data;

  factory ResponseModel.fromRawJson(String str) =>
      ResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        code: json["status_code"],
        success: json["success"],
        message: json["status_message"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "status_code": code,
        "success": success,
        "status_message": success,
        "data": data,
      };
}
