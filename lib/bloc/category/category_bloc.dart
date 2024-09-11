/*
 * *
 *  * category_bloc.dart - klontong
 *  * Created by Rahmat Trinanda (rahmat3nanda@gmail.com) on 09/11/2024, 13:28
 *  * Copyright (c) 2024 . All rights reserved.
 *  * Last modified 09/11/2024, 13:28
 *
 */

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klontong/bloc/category/category_event.dart';
import 'package:klontong/bloc/category/category_state.dart';
import 'package:klontong/common/constants.dart';
import 'package:klontong/data/request.dart';
import 'package:klontong/model/app/singleton_model.dart';
import 'package:klontong/model/category_model.dart';
import 'package:klontong/tool/helper.dart';

export 'package:klontong/bloc/category/category_event.dart';
export 'package:klontong/bloc/category/category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final Helper _helper = Helper();

  CategoryBloc(CategoryInitialState super.initialState) {
    on<CategoryDataEvent>(_data);
    on<CategoryCreateEvent>(_create);
    on<CategoryDetailEvent>(_detail);
    on<CategoryUpdateEvent>(_update);
    on<CategoryDeleteEvent>(_delete);
  }

  void _data(CategoryDataEvent event, Emitter<CategoryState> state) async {
    state(CategoryInitialState());
    try {
      Response res = await Request().category.data();
      List<CategoryModel> data = List<CategoryModel>.from(
          res.data.map((x) => CategoryModel.fromJson(x)));

      SingletonModel.shared.categories = data;
      AppLog.print(data);

      state(const CategoryDataSuccessState());
    } catch (e) {
      state(
        CategoryDataFailedState(_helper.dioErrorHandler(e)),
      );
    }
  }

  void _create(CategoryCreateEvent event, Emitter<CategoryState> state) async {
    state(CategoryInitialState());
    try {
      Response res = await Request().category.create(name: event.name);
      CategoryModel data = CategoryModel.fromJson(res.data);

      SingletonModel.shared.categories ??= [];
      SingletonModel.shared.categories!.add(data);
      AppLog.print(data);

      state(const CategoryCreateSuccessState());
    } catch (e) {
      state(
        CategoryCreateFailedState(_helper.dioErrorHandler(e)),
      );
    }
  }

  void _detail(CategoryDetailEvent event, Emitter<CategoryState> state) async {
    state(CategoryInitialState());
    try {
      Response res = await Request().category.detail(event.id);
      CategoryModel data = CategoryModel.fromJson(res.data);

      SingletonModel.shared.categories ??= [];
      int? index = SingletonModel.shared.categories!
          .indexWhereOrNull((e) => e.id == data.id);
      if (index != null) {
        SingletonModel.shared.categories![index] = data;
      } else {
        SingletonModel.shared.categories!.add(data);
      }

      AppLog.print(data);

      state(const CategoryDetailSuccessState());
    } catch (e) {
      state(
        CategoryDetailFailedState(_helper.dioErrorHandler(e)),
      );
    }
  }

  void _update(CategoryUpdateEvent event, Emitter<CategoryState> state) async {
    state(CategoryInitialState());
    try {
      Response res =
          await Request().category.update(event.id, name: event.name);
      CategoryModel data = CategoryModel.fromJson(res.data);

      SingletonModel.shared.categories ??= [];
      int? index = SingletonModel.shared.categories!
          .indexWhereOrNull((e) => e.id == data.id);
      if (index != null) {
        SingletonModel.shared.categories![index] = data;
      } else {
        SingletonModel.shared.categories!.add(data);
      }

      AppLog.print(data);

      state(const CategoryUpdateSuccessState());
    } catch (e) {
      state(
        CategoryUpdateFailedState(_helper.dioErrorHandler(e)),
      );
    }
  }

  void _delete(CategoryDeleteEvent event, Emitter<CategoryState> state) async {
    state(CategoryInitialState());
    try {
      await Request().category.delete(event.id);
      SingletonModel.shared.categories?.removeWhere((e) => e.id == event.id);

      state(const CategoryDeleteSuccessState());
    } catch (e) {
      state(
        CategoryDeleteFailedState(_helper.dioErrorHandler(e)),
      );
    }
  }
}
