/*
 * *
 *  * user_model.dart - klontong
 *  * Created by Rahmat Trinanda (rahmat3nanda@gmail.com) on 09/11/2024, 13:59
 *  * Copyright (c) 2024 . All rights reserved.
 *  * Last modified 09/11/2024, 13:59
 *
 */

class UserModel {
  final String? username;
  final String? password;

  UserModel({
    this.username,
    this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        username: json["username"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
      };
}
