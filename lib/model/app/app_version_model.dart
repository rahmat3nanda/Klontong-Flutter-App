/*
 * *
 *  * app_version_model.dart - Siadin Mobile
 *  * Created by Rahmat Trinanda (rahmat3nanda@gmail.com) on 07/08/2023, 17:40
 *  * Copyright (c) 2023 . All rights reserved.
 *  * Last modified 07/08/2023, 18:17
 *
 */

class AppVersionModel {
  late String name;
  late int number;

  AppVersionModel({required this.name, required this.number});

  factory AppVersionModel.empty() => AppVersionModel(name: "1.0.0", number: 1);

  @override
  String toString() => "$name($number)";
}
