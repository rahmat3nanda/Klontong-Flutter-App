/*
 * *
 *  * app_image.dart - klontong
 *  * Created by Rahmat Trinanda (rahmat3nanda@gmail.com) on 09/10/2024, 19:38
 *  * Copyright (c) 2024 . All rights reserved.
 *  * Last modified 07/13/2024, 18:04
 *
 */

const _path = "asset/images/";

class AppImage {
  static String klontong = "klontong.png".withImagePath();
  static String klontongFill = "klontong_fill.png".withImagePath();
}

extension AppImageString on String {
  String withImagePath({bool withPrefix = true}) {
    return "$_path${withPrefix ? "img_" : ""}$this";
  }
}
