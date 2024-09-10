
/*
 * *
 *  * theme.dart - klontong
 *  * Created by Rahmat Trinanda (rahmat3nanda@gmail.com) on 09/10/2024, 19:40
 *  * Copyright (c) 2024 . All rights reserved.
 *  * Last modified 07/14/2024, 01:32
 *
 */

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:klontong/common/styles/app_color.dart';

class AppTheme {
  static ThemeData main(BuildContext context) => ThemeData(
        appBarTheme: AppBarTheme(
          centerTitle: false,
          elevation: 0,
          backgroundColor: Colors.black,
          foregroundColor: AppColor.primary,
          surfaceTintColor: Colors.transparent,
          titleTextStyle: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColor.primary,
          ),
        ),
        cardTheme: const CardTheme(surfaceTintColor: Colors.transparent),
        dialogTheme: const DialogTheme(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
        ),
        tabBarTheme: TabBarTheme(
          labelColor: AppColor.primary,
          unselectedLabelColor: Colors.grey,
          labelStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
          unselectedLabelStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        primaryColor: AppColor.primaryLight,
        primaryColorDark: AppColor.primary,
        scaffoldBackgroundColor: Colors.black,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: AppColor.secondary,
        ),
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme.apply(
                bodyColor: Colors.white,
                displayColor: Colors.white,
              ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.symmetric(horizontal: 24.0),
          hintStyle: const TextStyle(fontWeight: FontWeight.w500),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: AppColor.primary),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: Colors.red),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(width: 1, color: AppColor.secondary),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(width: 1, color: Colors.transparent),
          ),
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: AppColor.secondary,
        ),
      );
}
