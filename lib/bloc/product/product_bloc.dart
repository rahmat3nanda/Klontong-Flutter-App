/*
 * *
 *  * product_bloc.dart - klontong
 *  * Created by Rahmat Trinanda (rahmat3nanda@gmail.com) on 09/12/2024, 18:54
 *  * Copyright (c) 2024 . All rights reserved.
 *  * Last modified 09/12/2024, 15:05
 *
 */

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klontong/bloc/product/product_event.dart';
import 'package:klontong/bloc/product/product_state.dart';
import 'package:klontong/common/constants.dart';
import 'package:klontong/data/request.dart';
import 'package:klontong/model/app/singleton_model.dart';
import 'package:klontong/model/product_model.dart';
import 'package:klontong/model/response_model.dart';
import 'package:klontong/tool/helper.dart';

export 'package:klontong/bloc/product/product_event.dart';
export 'package:klontong/bloc/product/product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final Helper _helper = Helper();

  ProductBloc(ProductInitialState super.initialState) {
    on<ProductDataEvent>(_data);
    on<ProductCreateEvent>(_create);
    on<ProductDetailEvent>(_detail);
    on<ProductUpdateEvent>(_update);
    on<ProductDeleteEvent>(_delete);
  }

  void _data(ProductDataEvent event, Emitter<ProductState> state) async {
    state(ProductInitialState());
    try {
      Response res = await Request().product.data(event.page);
      List<ProductModel> data = List<ProductModel>.from(
          res.data.map((x) => ProductModel.fromJson(x)));

      if (data.isEmpty) {
        state(
          ProductDataFailedState(ResponseModel(code: 404, message: "No Data")),
        );
        return;
      }

      if (event.page == 0) {
        SingletonModel.shared.products = data;
      } else {
        SingletonModel.shared.products!.addAll(data);
      }

      AppLog.print(data);

      state(ProductDataSuccessState(event.page));
    } catch (e) {
      state(
        ProductDataFailedState(_helper.dioErrorHandler(e)),
      );
    }
  }

  void _create(ProductCreateEvent event, Emitter<ProductState> state) async {
    state(ProductInitialState());
    try {
      Response res = await Request().product.create(
            categoryId: event.category.id!,
            categoryName: event.category.name!,
            sku: event.sku,
            name: event.name,
            description: event.description,
            weight: event.weight,
            width: event.width,
            length: event.length,
            height: event.height,
            image: event.image,
            price: event.price,
          );

      ProductModel data = ProductModel.fromJson(res.data);

      SingletonModel.shared.products ??= [];
      SingletonModel.shared.products!.add(data);
      AppLog.print(data);

      state(const ProductCreateSuccessState());
    } catch (e) {
      state(
        ProductCreateFailedState(_helper.dioErrorHandler(e)),
      );
    }
  }

  void _detail(ProductDetailEvent event, Emitter<ProductState> state) async {
    state(ProductInitialState());
    try {
      Response res = await Request().product.detail(event.id);
      ProductModel data = ProductModel.fromJson(res.data);

      SingletonModel.shared.products ??= [];
      int? index = SingletonModel.shared.products!
          .indexWhereOrNull((e) => e.id == data.id);
      if (index != null) {
        SingletonModel.shared.products![index] = data;
      } else {
        SingletonModel.shared.products!.add(data);
      }

      AppLog.print(data);

      state(const ProductDetailSuccessState());
    } catch (e) {
      state(
        ProductDetailFailedState(_helper.dioErrorHandler(e)),
      );
    }
  }

  void _update(ProductUpdateEvent event, Emitter<ProductState> state) async {
    state(ProductInitialState());
    try {
      await Request().product.update(
            event.id,
            categoryId: event.category.id!,
            categoryName: event.category.name!,
            sku: event.sku,
            name: event.name,
            description: event.description,
            weight: event.weight,
            width: event.width,
            length: event.length,
            height: event.height,
            image: event.image,
            price: event.price,
          );
      ProductModel data = ProductModel(
        id: event.id,
        category: event.category,
        sku: event.sku,
        name: event.name,
        description: event.description,
        weight: event.weight,
        width: event.width,
        length: event.length,
        height: event.height,
        image: event.image,
        price: event.price,
      );

      SingletonModel.shared.products ??= [];
      int? index = SingletonModel.shared.products!
          .indexWhereOrNull((e) => e.id == event.id);
      if (index != null) {
        SingletonModel.shared.products![index] = data;
      } else {
        SingletonModel.shared.products!.add(data);
      }

      AppLog.print(data);

      state(const ProductUpdateSuccessState());
    } catch (e) {
      AppLog.print(e);
      state(
        ProductUpdateFailedState(_helper.dioErrorHandler(e)),
      );
    }
  }

  void _delete(ProductDeleteEvent event, Emitter<ProductState> state) async {
    state(ProductInitialState());
    try {
      await Request().product.delete(event.id);
      SingletonModel.shared.products?.removeWhere((e) => e.id == event.id);

      state(const ProductDeleteSuccessState());
    } catch (e) {
      state(
        ProductDeleteFailedState(_helper.dioErrorHandler(e)),
      );
    }
  }
}
