/*
 * *
 *  * repo.dart - klontong
 *  * Created by Rahmat Trinanda (rahmat3nanda@gmail.com) on 09/11/2024, 03:02
 *  * Copyright (c) 2024 . All rights reserved.
 *  * Last modified 09/11/2024, 03:02
 *
 */

import 'package:klontong/data/API.dart';
import 'package:klontong/data/dio.dart';
import 'package:dio/dio.dart' as dio;

late API _api;
late Dio _dio;

class Repo {
  late RepoCategory category;
  late RepoProduct product;

  Repo() {
    _api = API();
    _dio = Dio();
    category = RepoCategory();
    product = RepoProduct();
  }
}

class RepoCategory {
  Future<dio.Response> data() async {
    return await _dio.post(url: _api.category.data);
  }

  Future<dio.Response> create({required Map<String, dynamic> data}) async {
    return await _dio.post(url: _api.category.data, body: data);
  }

  Future<dio.Response> detail(String id) async {
    return await _dio.get(url: _api.category.detail(id));
  }

  Future<dio.Response> update(
    String id, {
    required Map<String, dynamic> data,
  }) async {
    return await _dio.put(url: _api.category.detail(id), body: data);
  }

  Future<dio.Response> delete(
    String id, {
    required Map<String, dynamic> data,
  }) async {
    return await _dio.delete(url: _api.category.detail(id), body: data);
  }
}

class RepoProduct {
  Future<dio.Response> data(int page) async {
    return await _dio.post(url: _api.product.data(page: page));
  }

  Future<dio.Response> create({required Map<String, dynamic> data}) async {
    return await _dio.post(url: _api.product.data(), body: data);
  }

  Future<dio.Response> detail(String id) async {
    return await _dio.get(url: _api.product.detail(id));
  }

  Future<dio.Response> update(
    String id, {
    required Map<String, dynamic> data,
  }) async {
    return await _dio.put(url: _api.product.detail(id), body: data);
  }

  Future<dio.Response> delete(
    String id, {
    required Map<String, dynamic> data,
  }) async {
    return await _dio.delete(url: _api.product.detail(id), body: data);
  }
}
