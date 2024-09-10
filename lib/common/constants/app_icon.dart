/*
 * *
 *  * app_icon.dart - klontong
 *  * Created by Rahmat Trinanda (rahmat3nanda@gmail.com) on 09/10/2024, 19:38
 *  * Copyright (c) 2024 . All rights reserved.
 *  * Last modified 07/13/2024, 18:04
 *
 */

const _path = "asset/icons/";

class AppIcon {
  static String klontong = "klontong.svg".withIconPath();
}

extension AppIconString on String {
  String withIconPath({bool withPrefix = true, String group = ""}) {
    return "$_path$group${group.isEmpty ? "" : "/"}${withPrefix ? "ic_${group.isEmpty ? "" : "${group}_"}" : ""}$this";
  }
}
