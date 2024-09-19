/*
 * *
 *  * main_page.dart - klontong
 *  * Created by Rahmat Trinanda (rahmat3nanda@gmail.com) on 09/12/2024, 02:06
 *  * Copyright (c) 2024 . All rights reserved.
 *  * Last modified 09/12/2024, 02:06
 *
 */

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:klontong/common/styles.dart';
import 'package:klontong/dialog/app_alert_dialog.dart';
import 'package:klontong/model/app/button_action_model.dart';
import 'package:klontong/model/app/singleton_model.dart';
import 'package:klontong/page/category_page.dart';
import 'package:klontong/page/product/product_page.dart';
import 'package:klontong/page/profile_page.dart';
import 'package:klontong/tool/helper.dart';
import 'package:klontong/widget/loading_overlay.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  late Helper _helper;
  late TabController _tabController;
  late bool _isLoading;
  late int _page;

  @override
  void initState() {
    super.initState();
    SingletonModel.withContext(context);
    _helper = Helper();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _page = _tabController.index;
      });
    });
    _isLoading = false;
    _page = 0;
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  void _onPageChanged(int i) {
    setState(() {
      _page = i;
      _tabController.animateTo(i);
    });
  }

  void _onPopInvoked(bool invoke) async {
    if (_isLoading) {
      return;
    }
    if (_page != 0) {
      setState(() {
        _page = 0;
        _tabController.animateTo(_page);
      });

      return;
    }

    bool? exit = await openAppAlertDialog(
      context,
      title: "Exit",
      message: "Are you sure you want to exit?",
      actions: [
        ButtonActionModel(
          child: const Text("No"),
          onTap: (c) => Navigator.pop(c, false),
        ),
        ButtonActionModel(
          child: const Text(
            "Yes",
            style: TextStyle(color: Colors.red),
          ),
          onTap: (c) => Navigator.pop(c, true),
        ),
      ],
    );

    if (exit == true) {
      _helper.exitApp();
    }
  }

  void _showLoading(bool b) {
    setState(() {
      _isLoading = b;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: _onPopInvoked,
      child: Scaffold(
        body: LoadingOverlay(
          isLoading: _isLoading,
          color: Colors.white.withOpacity(0.6),
          progressIndicator: SpinKitWaveSpinner(
            color: AppColor.primaryLight,
            trackColor: AppColor.primary,
            waveColor: AppColor.secondary,
            size: 64,
          ),
          child: TabBarView(
            controller: _tabController,
            children: [
              const ProductPage(),
              CategoryPage(showLoading: _showLoading),
              ProfilePage(showLoading: _showLoading),
            ],
          ),
        ),
        bottomNavigationBar: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(.2),
                    spreadRadius: 3,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(24)),
                child: BottomNavigationBar(
                  selectedFontSize: 10,
                  selectedItemColor: AppColor.primary,
                  unselectedFontSize: 10,
                  unselectedItemColor: AppColor.primary,
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Colors.white,
                  items: <BottomNavigationBarItem>[
                    _itemMenu(
                      index: 0,
                      icon: FontAwesomeIcons.inbox,
                      title: "Products",
                    ),
                    _itemMenu(
                      index: 1,
                      icon: FontAwesomeIcons.list,
                      title: "Categories",
                    ),
                    _itemMenu(
                      index: 2,
                      icon: FontAwesomeIcons.user,
                      title: "Profile",
                    ),
                  ],
                  currentIndex: _page,
                  onTap: _onPageChanged,
                ),
              ),
            ),
            if (_isLoading)
              Positioned.fill(
                child: Opacity(
                  opacity: 0.5,
                  child: Container(color: Colors.white.withOpacity(0.6)),
                ),
              ),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _itemMenu({
    required int index,
    required IconData icon,
    required String title,
  }) {
    return BottomNavigationBarItem(
      icon: FaIcon(
        icon,
        color: _page == index ? AppColor.primary : Colors.grey,
      ),
      label: title,
      tooltip: title,
    );
  }
}
