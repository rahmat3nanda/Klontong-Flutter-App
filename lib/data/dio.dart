/*
 * *
 *  * dio.dart - klontong
 *  * Created by Rahmat Trinanda (rahmat3nanda@gmail.com) on 09/11/2024, 02:40
 *  * Copyright (c) 2024 . All rights reserved.
 *  * Last modified 07/14/2024, 01:47
 *
 */

import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart' as d;
import 'package:klontong/common/configs.dart';
import 'package:klontong/common/constants.dart';

class Dio {
  late d.Dio _dio;

  Dio({Map<String, dynamic>? headers}) {
    _dio = d.Dio();
    _dio.options = d.BaseOptions(
      baseUrl: AppConfig.shared.baseUrlApi,
      headers: headers ??
          {
            "Accept": "application/json",
            "Content-Type": "application/json",
          },
    );
    _dio.interceptors.add(
      d.InterceptorsWrapper(
          onRequest: (d.RequestOptions o, d.RequestInterceptorHandler h) {
        AppLog.print("URL request : ${o.uri}");
        return h.next(o);
      }, onResponse: (d.Response r, d.ResponseInterceptorHandler h) {
        return h.next(r);
      }, onError: (d.DioException e, d.ErrorInterceptorHandler h) async {
        AppLog.print("URL error : ${e.requestOptions.path}");
        AppLog.print("Message error : ${e.message}");
        AppLog.print("Response error : ${e.response}");

        return h.next(e);
      }),
    );
  }

  Future post({
    required String url,
    dynamic body,
    Map<String, dynamic>? param,
  }) async {
    try {
      return await _dio.post(
        url,
        queryParameters: param,
        data: body,
      );
    } on TimeoutException catch (e) {
      return Future.error(e);
    } on SocketException catch (e) {
      return Future.error(e);
    } on d.DioException catch (e) {
      return Future.error(e);
    }
  }

  Future patch({
    required String url,
    required dynamic body,
    Map<String, dynamic>? param,
  }) async {
    try {
      return await _dio.patch(
        url,
        queryParameters: param,
        data: body,
      );
    } on TimeoutException catch (e) {
      return Future.error(e);
    } on SocketException catch (e) {
      return Future.error(e);
    } on d.DioException catch (e) {
      return Future.error(e);
    }
  }

  Future put({
    required String url,
    required dynamic body,
    Map<String, dynamic>? param,
  }) async {
    try {
      return await _dio.put(
        url,
        queryParameters: param,
        data: body,
      );
    } on TimeoutException catch (e) {
      return Future.error(e);
    } on SocketException catch (e) {
      return Future.error(e);
    } on d.DioException catch (e) {
      return Future.error(e);
    }
  }

  Future get({
    required String url,
    Map<String, dynamic>? param,
  }) async {
    try {
      return await _dio.get(
        url,
        queryParameters: param,
      );
    } on TimeoutException catch (e) {
      return Future.error(e);
    } on SocketException catch (e) {
      return Future.error(e);
    } on d.DioException catch (e) {
      return Future.error(e);
    }
  }

  Future delete({
    required String url,
    dynamic body,
    Map<String, dynamic>? param,
  }) async {
    try {
      return await _dio.delete(
        url,
        queryParameters: param,
        data: body,
      );
    } on TimeoutException catch (e) {
      return Future.error(e);
    } on SocketException catch (e) {
      return Future.error(e);
    } on d.DioException catch (e) {
      return Future.error(e);
    }
  }
}
