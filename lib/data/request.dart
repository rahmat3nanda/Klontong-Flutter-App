/*
 * *
 *  * request.dart - klontong
 *  * Created by Rahmat Trinanda (rahmat3nanda@gmail.com) on 09/11/2024, 03:28
 *  * Copyright (c) 2024 . All rights reserved.
 *  * Last modified 09/11/2024, 03:28
 *
 */

import 'package:dio/dio.dart' as dio;
import 'package:klontong/data/repo.dart';

late Repo _repo;

class Request {
  late RequestCategory category;
  late RequestProduct product;

  Request() {
    _repo = Repo();
    category = RequestCategory();
    product = RequestProduct();
  }
}

class RequestCategory {
  Future<dio.Response> data() {
    return _repo.category.data();
  }

  Future<dio.Response> create({required String name}) {
    return _repo.category.create(data: {"name": name});
  }

  Future<dio.Response> detail(String id) {
    return _repo.category.detail(id);
  }

  Future<dio.Response> update(String id, {required String name}) {
    return _repo.category.update(id, data: {"name": name});
  }

  Future<dio.Response> delete(String id) {
    return _repo.category.delete(id);
  }
}

class RequestProduct {
  Future<dio.Response> data(int page) {
    return _repo.product.data(page);
  }

  Future<dio.Response> create(
    int page, {
    required String categoryId,
    required String categoryName,
    required String sku,
    required String name,
    required String description,
    required double weight,
    required double width,
    required double length,
    required double height,
    required String image,
    required int price,
  }) {
    return _repo.product.create(page, data: {
      "category": {
        "_id": categoryId,
        "name": categoryName,
      },
      "sku": sku,
      "name": name,
      "description": description,
      "weight": weight,
      "width": width,
      "length": length,
      "height": height,
      "image": image,
      "price": price,
    });
  }

  Future<dio.Response> detail(String id) {
    return _repo.product.detail(id);
  }

  Future<dio.Response> update(
    String id, {
    required String categoryId,
    required String categoryName,
    required String sku,
    required String name,
    required String description,
    required double weight,
    required double width,
    required double length,
    required double height,
    required String image,
    required int price,
  }) {
    return _repo.product.update(id, data: {
      "category": {
        "_id": categoryId,
        "name": categoryName,
      },
      "sku": sku,
      "name": name,
      "description": description,
      "weight": weight,
      "width": width,
      "length": length,
      "height": height,
      "image": image,
      "price": price,
    });
  }

  Future<dio.Response> delete(String id) {
    return _repo.product.delete(id);
  }
}
