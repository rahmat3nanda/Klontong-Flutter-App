/*
 * *
 *  * product_model.dart - klontong
 *  * Created by Rahmat Trinanda (rahmat3nanda@gmail.com) on 09/11/2024, 02:37
 *  * Copyright (c) 2024 . All rights reserved.
 *  * Last modified 09/11/2024, 02:37
 *
 */

import 'package:klontong/model/category_model.dart';

class ProductModel {
  final String? id;
  final CategoryModel? category;
  final String? sku;
  final String? name;
  final String? description;
  final int? weight;
  final int? width;
  final int? length;
  final int? height;
  final String? image;
  final int? price;

  ProductModel({
    this.id,
    this.category,
    this.sku,
    this.name,
    this.description,
    this.weight,
    this.width,
    this.length,
    this.height,
    this.image,
    this.price,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["_id"],
        category: json["category"] == null
            ? null
            : CategoryModel.fromJson(json["category"]),
        sku: json["sku"],
        name: json["name"],
        description: json["description"],
        weight: json["weight"],
        width: json["width"],
        length: json["length"],
        height: json["height"],
        image: json["image"],
        price: json["harga"],
      );

  Map<String, dynamic> toJson() => {
        if (id != null) "_id": id,
        "category": category?.toJson(),
        "sku": sku,
        "name": name,
        "description": description,
        "weight": weight,
        "width": width,
        "length": length,
        "height": height,
        "image": image,
        "harga": price,
      };
}
