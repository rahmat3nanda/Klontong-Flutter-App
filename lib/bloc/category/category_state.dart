/*
 * *
 *  * category_state.dart - klontong
 *  * Created by Rahmat Trinanda (rahmat3nanda@gmail.com) on 09/12/2024, 02:29
 *  * Copyright (c) 2024 . All rights reserved.
 *  * Last modified 09/11/2024, 13:31
 *  
 */

import 'package:equatable/equatable.dart';
import 'package:klontong/model/response_model.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

class CategoryInitialState extends CategoryState {}

class CategoryDataSuccessState extends CategoryState {
  const CategoryDataSuccessState();
}

class CategoryDataFailedState extends CategoryState {
  final ResponseModel data;

  const CategoryDataFailedState(this.data);
}

class CategoryCreateSuccessState extends CategoryState {
  const CategoryCreateSuccessState();
}

class CategoryCreateFailedState extends CategoryState {
  final ResponseModel data;

  const CategoryCreateFailedState(this.data);
}

class CategoryDetailSuccessState extends CategoryState {
  const CategoryDetailSuccessState();
}

class CategoryDetailFailedState extends CategoryState {
  final ResponseModel data;

  const CategoryDetailFailedState(this.data);
}

class CategoryUpdateSuccessState extends CategoryState {
  const CategoryUpdateSuccessState();
}

class CategoryUpdateFailedState extends CategoryState {
  final ResponseModel data;

  const CategoryUpdateFailedState(this.data);
}

class CategoryDeleteSuccessState extends CategoryState {
  const CategoryDeleteSuccessState();
}

class CategoryDeleteFailedState extends CategoryState {
  final ResponseModel data;

  const CategoryDeleteFailedState(this.data);
}
