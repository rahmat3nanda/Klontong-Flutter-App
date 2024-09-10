/*
 * *
 *  * api.dart - klontong
 *  * Created by Rahmat Trinanda (rahmat3nanda@gmail.com) on 09/11/2024, 02:42
 *  * Copyright (c) 2024 . All rights reserved.
 *  * Last modified 09/11/2024, 02:42
 *
 */

class API {
  APICategory category = APICategory();
  APIProduct product = APIProduct();
}

class APICategory {
  final String data = "category";
}

class APIProduct {
   String data(int page) => "product/$page";
   String detail(String id) => "product/$id";
}
