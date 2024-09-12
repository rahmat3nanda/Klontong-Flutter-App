/*
 * *
 *  * app_bar_widget.dart - klontong
 *  * Created by Rahmat Trinanda (rahmat3nanda@gmail.com) on 09/12/2024, 18:23
 *  * Copyright (c) 2024 . All rights reserved.
 *  * Last modified 09/12/2024, 18:23
 *
 */

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:klontong/common/constants.dart';
import 'package:klontong/common/styles.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String? subtitle;

  const AppBarWidget({super.key, this.subtitle});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          SvgPicture.asset(AppIcon.klontong, height: kToolbarHeight * 0.5),
          const SizedBox(width: 16),
          Text(
            "Klontong",
            style: TextStyle(
              color: AppColor.primaryLight,
              fontWeight: FontWeight.w700,
            ),
          ),
          Expanded(child: Container()),
          if (subtitle != null)
            Text(
              subtitle ?? "",
              style: TextStyle(
                color: AppColor.primaryLight,
                fontSize: 16,
              ),
            ),
        ],
      ),
    );
  }
}
