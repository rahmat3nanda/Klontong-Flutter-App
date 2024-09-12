/*
 * *
 *  * product_page.dart - klontong
 *  * Created by Rahmat Trinanda (rahmat3nanda@gmail.com) on 09/13/2024, 01:27
 *  * Copyright (c) 2024 . All rights reserved.
 *  * Last modified 09/13/2024, 01:26
 *  
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:klontong/bloc/product/product_bloc.dart';
import 'package:klontong/common/styles.dart';
import 'package:klontong/dialog/app_alert_dialog.dart';
import 'package:klontong/model/app/button_action_model.dart';
import 'package:klontong/model/app/singleton_model.dart';
import 'package:klontong/model/error_model.dart';
import 'package:klontong/model/product_model.dart';
import 'package:klontong/page/auth_page.dart';
import 'package:klontong/page/product/product_add_page.dart';
import 'package:klontong/page/product/product_detail_page.dart';
import 'package:klontong/tool/helper.dart';
import 'package:klontong/widget/app_bar_widget.dart';
import 'package:klontong/widget/image_network_widget.dart';
import 'package:klontong/widget/reload_data_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late SingletonModel _model;
  late Helper _helper;
  late ProductBloc _bloc;

  late RefreshController _cRefresh;
  late int _page;
  ErrorModel? _error;
  late bool _onLoad;

  @override
  void initState() {
    super.initState();
    _model = SingletonModel.withContext(context);
    _helper = Helper();
    _bloc = BlocProvider.of<ProductBloc>(context);
    _cRefresh = RefreshController(initialRefresh: false);
    _page = 0;
    _onLoad = false;
    _onRefresh(fromCache: true);
  }

  void _onRefresh({bool fromCache = false}) {
    _page = 0;
    _getData(fromCache: fromCache);
    _cRefresh.refreshCompleted();
  }

  void _getData({bool fromCache = false}) {
    _onLoad = true;
    _error = null;

    if (fromCache && _model.products != null) {
      _onLoad = false;
      return;
    }

    _bloc.add(ProductDataEvent(_page));
  }

  void _createItem() async {
    bool isAuth = await _checkAuth();
    if (!isAuth) {
      return;
    }

    bool? created =
        await _helper.jumpToPage(context, page: const ProductAddPage());
    if (created == true) {
      _model = SingletonModel.withContext(context);
    }
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
        if (s is ProductDataSuccessState) {
          _onLoad = false;
          _model = SingletonModel.withContext(context);
          _page = s.page;
        } else if (s is ProductDataFailedState) {
          _onLoad = false;
          _model = SingletonModel.withContext(context);
          _cRefresh.loadComplete();

          if ((_model.products?.isNotEmpty ?? false) && s.data.code != 404) {
            _helper.showToast("Failure to load data");
          }
          _error = ErrorModel(
            event: ProductDataEvent(_page),
            error: s.data.message,
          );
        }
      },
      child: BlocBuilder(
        bloc: _bloc,
        builder: (c, s) {
          return Scaffold(
            appBar: const AppBarWidget(subtitle: "Products"),
            floatingActionButton: FloatingActionButton(
              backgroundColor: AppColor.primary,
              onPressed: _createItem,
              tooltip: "Create Product",
              child: const Icon(Icons.add),
            ),
            body: SafeArea(
              child: SmartRefresher(
                primary: true,
                physics: const ClampingScrollPhysics(),
                enablePullDown:
                    (_error == null || (_error != null && _page > 0)) &&
                        !_onLoad,
                enablePullUp: _error == null,
                header: WaterDropMaterialHeader(
                  backgroundColor: AppColor.primary,
                  color: AppColor.secondary,
                ),
                footer: CustomFooter(
                  builder: (context, status) => SpinKitWave(
                    color: AppColor.primary,
                    size: 32,
                  ),
                ),
                controller: _cRefresh,
                onRefresh: _onRefresh,
                onLoading: () => setState(() {
                  _bloc.add(ProductDataEvent(_page + 1));
                  _cRefresh.loadComplete();
                }),
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

    if (_error != null && _page == 0) {
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
    if (_model.products?.isEmpty ?? true) {
      return const Center(
        child: Text("No data yet"),
      );
    }

    double imageSize = 100.0;
    int gridCount = (MediaQuery.of(context).size.width - 152) ~/ imageSize;
    return GridView.builder(
      shrinkWrap: true,
      primary: false,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _model.products?.length ?? 0,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: gridCount,
        crossAxisSpacing: 2.0,
        mainAxisSpacing: 2.0,
        childAspectRatio: 0.8,
      ),
      itemBuilder: (c, i) {
        ProductModel d = _model.products![i];
        return Card(
          child: InkWell(
            splashColor: AppColor.secondary,
            borderRadius: BorderRadius.circular(12),
            onTap: () => _helper.jumpToPage(
              context,
              page: ProductDetailPage(item: d),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 7,
                  child: ImageNetworkWidget(
                    url: d.image ?? "",
                    clickable: false,
                    radius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          d.name ?? "",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(d.price.toMoney()),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
