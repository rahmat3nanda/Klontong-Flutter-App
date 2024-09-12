/*
 * *
 *  * category_page.dart - klontong
 *  * Created by Rahmat Trinanda (rahmat3nanda@gmail.com) on 09/12/2024, 13:34
 *  * Copyright (c) 2024 . All rights reserved.
 *  * Last modified 09/12/2024, 13:34
 *
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:klontong/bloc/category/category_bloc.dart';
import 'package:klontong/common/styles.dart';
import 'package:klontong/dialog/app_alert_dialog.dart';
import 'package:klontong/dialog/category_field_dialog.dart';
import 'package:klontong/model/app/button_action_model.dart';
import 'package:klontong/model/app/singleton_model.dart';
import 'package:klontong/model/category_model.dart';
import 'package:klontong/model/error_model.dart';
import 'package:klontong/page/auth_page.dart';
import 'package:klontong/tool/helper.dart';
import 'package:klontong/widget/app_bar_widget.dart';
import 'package:klontong/widget/reload_data_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CategoryPage extends StatefulWidget {
  final Function(bool isLoading) showLoading;

  const CategoryPage({super.key, required this.showLoading});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  late SingletonModel _model;
  late Helper _helper;
  late CategoryBloc _bloc;

  late RefreshController _cRefresh;
  ErrorModel? _error;
  late bool _onLoad;

  @override
  void initState() {
    super.initState();
    _model = SingletonModel.withContext(context);
    _helper = Helper();
    _bloc = BlocProvider.of<CategoryBloc>(context);
    _cRefresh = RefreshController(initialRefresh: false);
    _onLoad = false;
    _onRefresh(fromCache: true);
  }

  void _onRefresh({bool fromCache = false}) {
    _getData(fromCache: fromCache);
    _cRefresh.refreshCompleted();
  }

  void _getData({bool fromCache = false}) {
    _onLoad = true;
    if (fromCache && _model.categories != null) {
      _onLoad = false;
      return;
    }

    _bloc.add(const CategoryDataEvent());
  }

  void _createItem() async {
    bool isAuth = await _checkAuth();
    if (!isAuth) {
      return;
    }

    String? name = await openCategoryFieldDialog(
      _model.context!,
      action: "Create",
    );
    if (name == null) {
      return;
    }

    if (name.trim().isEmpty) {
      _helper.showToast("Cannot be Empty!");
      return;
    }

    widget.showLoading(true);
    _bloc.add(CategoryCreateEvent(name: name.trim()));
  }

  Future<bool> _confirmDismiss(
    DismissDirection direction,
    CategoryModel item,
  ) async {
    if (direction == DismissDirection.endToStart) {
      return _deleteItem(item);
    }
    if (direction == DismissDirection.startToEnd) {
      return _updateItem(item);
    }

    return Future.value(false);
  }

  Future<bool> _deleteItem(CategoryModel item) async {
    bool isAuth = await _checkAuth();
    if (!isAuth) {
      return Future.value(false);
    }

    bool? delete = await openAppAlertDialog(
      _model.context!,
      title: "Delete Category",
      message:
          "Are you sure you want to delete \"${item.name ?? ""}\" category?",
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

    if (delete != true) {
      return Future.value(false);
    }

    setState(() {
      _model.categories!.remove(item);
    });

    _bloc.add(CategoryDeleteEvent(item.id ?? ""));

    return Future.value(true);
  }

  Future<bool> _updateItem(CategoryModel item) async {
    bool isAuth = await _checkAuth();
    if (!isAuth) {
      return Future.value(false);
    }

    String? name = await openCategoryFieldDialog(
      _model.context!,
      action: "Update",
      category: item,
    );

    if (name == null) {
      return Future.value(false);
    }

    if (name.trim().isEmpty) {
      _helper.showToast("Cannot be Empty!");
      return Future.value(false);
    }

    setState(() {
      _model.categories?.firstWhereOrNull((e) => e.id == item.id)?.name =
          name.trim();
    });

    _bloc.add(CategoryUpdateEvent(id: item.id ?? "", name: name.trim()));

    return Future.value(false);
  }

  Future<bool> _checkAuth() async {
    if (SingletonModel.shared.isLoggedIn == true) {
      return Future.value(true);
    }

    bool? signIn = await openAppAlertDialog(
      context,
      title: "Sign In to continue",
      message: "Do you want to Sign In?",
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

    if (signIn == true) {
      _helper
          .jumpToPage(
            _model.context!,
            page: const AuthPage(),
          )
          .then((_) => _model = SingletonModel.shared);
    }

    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    _model = SingletonModel.withContext(context);
    return BlocListener(
      bloc: _bloc,
      listener: (c, s) {
        if (s is CategoryDataSuccessState) {
          _onLoad = false;
          _model = SingletonModel.withContext(context);
        } else if (s is CategoryDataFailedState) {
          _onLoad = false;
          if (_model.categories?.isEmpty ?? true) {
            _error = ErrorModel(
              event: const CategoryDataEvent(),
              error: s.data.message,
            );
          } else {
            _helper.showToast("Failure to reload");
          }
        } else if (s is CategoryCreateSuccessState) {
          widget.showLoading(false);
          _model = SingletonModel.withContext(context);
          _helper.showToast("Success Create Category");
        } else if (s is CategoryCreateFailedState) {
          widget.showLoading(false);
          _model = SingletonModel.withContext(context);
          _helper.showToast("Failure Create Category");
        } else if (s is CategoryUpdateSuccessState) {
          _model = SingletonModel.withContext(context);
          _helper.showToast("Success Update Category");
        } else if (s is CategoryUpdateFailedState) {
          _model = SingletonModel.withContext(context);
          _helper.showToast("Failure Update Category");
        } else if (s is CategoryDeleteSuccessState) {
          _model = SingletonModel.withContext(context);
          _helper.showToast("Success Delete Category");
        } else if (s is CategoryDeleteFailedState) {
          _model = SingletonModel.withContext(context);
          _helper.showToast("Failure Delete Category");
        }
      },
      child: BlocBuilder(
        bloc: _bloc,
        builder: (c, s) {
          return Scaffold(
            appBar: const AppBarWidget(subtitle: "Categories"),
            floatingActionButton: FloatingActionButton(
              backgroundColor: AppColor.primary,
              onPressed: _createItem,
              tooltip: "Create Category",
              child: const Icon(Icons.add),
            ),
            body: SafeArea(
              child: SmartRefresher(
                primary: true,
                physics: const ClampingScrollPhysics(),
                enablePullDown: _error == null && !_onLoad,
                enablePullUp: false,
                header: WaterDropMaterialHeader(
                  backgroundColor: AppColor.primary,
                  color: AppColor.secondary,
                ),
                footer: CustomFooter(
                  builder: (context, status) => Container(),
                ),
                controller: _cRefresh,
                onRefresh: _onRefresh,
                child: _stateView(),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _stateView() {
    if (_onLoad) {
      return Column(
        children: [
          Expanded(
            child: SpinKitWaveSpinner(
              color: AppColor.primaryLight,
              trackColor: AppColor.primary,
              waveColor: AppColor.secondary,
              size: 64,
            ),
          ),
        ],
      );
    }

    if (_error != null) {
      return Column(
        children: [
          Expanded(
            child: ReloadDataWidget(
              error: "Gagal memuat data",
              onReload: _onRefresh,
            ),
          ),
        ],
      );
    }

    return _mainView();
  }

  Widget _mainView() {
    if (_model.categories?.isEmpty ?? true) {
      return const Center(
        child: Text("No data yet"),
      );
    }
    return ListView.separated(
      itemCount: _model.categories?.length ?? 0,
      padding: const EdgeInsets.all(12),
      separatorBuilder: (_, __) => const Divider(color: Colors.grey),
      itemBuilder: (_, i) {
        CategoryModel d = _model.categories![i];
        return Dismissible(
          key: Key(d.id ?? ""),
          background: Container(
            color: AppColor.secondary,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 8),
                Icon(Icons.edit, color: Colors.white),
                SizedBox(width: 12),
                Text(
                  "Edit",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          secondaryBackground: Container(
            color: Colors.red,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Delete",
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(width: 12),
                Icon(Icons.delete_forever, color: Colors.white),
                SizedBox(width: 8),
              ],
            ),
          ),
          confirmDismiss: (dir) => _confirmDismiss(dir, d),
          child: ListTile(
            title: Text(d.name ?? ""),
            minTileHeight: 36,
            onTap: () => _helper.showToast("Swipe item for Action"),
            onLongPress: () => _helper.showToast("Swipe item for Action"),
          ),
        );
      },
    );
  }
}
