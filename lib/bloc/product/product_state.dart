/*
 * *
 *  * product_state.dart - klontong
 *  * Created by Rahmat Trinanda (rahmat3nanda@gmail.com) on 09/12/2024, 18:53
 *  * Copyright (c) 2024 . All rights reserved.
 *  * Last modified 09/12/2024, 02:39
 *
 */

import 'package:equatable/equatable.dart';
import 'package:klontong/model/response_model.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitialState extends ProductState {}

class ProductDataSuccessState extends ProductState {
  final int page;

  const ProductDataSuccessState(this.page);
}

class ProductDataFailedState extends ProductState {
  final ResponseModel data;

  const ProductDataFailedState(this.data);
}

class ProductCreateSuccessState extends ProductState {
  const ProductCreateSuccessState();
}

class ProductCreateFailedState extends ProductState {
  final ResponseModel data;

  const ProductCreateFailedState(this.data);
}

class ProductDetailSuccessState extends ProductState {
  const ProductDetailSuccessState();
}

class ProductDetailFailedState extends ProductState {
  final ResponseModel data;

  const ProductDetailFailedState(this.data);
}

class ProductUpdateSuccessState extends ProductState {
  const ProductUpdateSuccessState();
}

class ProductUpdateFailedState extends ProductState {
  final ResponseModel data;

  const ProductUpdateFailedState(this.data);
}

class ProductDeleteSuccessState extends ProductState {
  const ProductDeleteSuccessState();
}

class ProductDeleteFailedState extends ProductState {
  final ResponseModel data;

  const ProductDeleteFailedState(this.data);
}
