/*
 * *
 *  * category_model.dart - klontong
 *  * Created by Rahmat Trinanda (rahmat3nanda@gmail.com) on 09/11/2024, 02:35
 *  * Copyright (c) 2024 . All rights reserved.
 *  * Last modified 09/11/2024, 02:35
 *
 */

class CategoryModel {
  String? name;
  final String? id;

  CategoryModel({
    this.name,
    this.id,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        name: json["name"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        if (id != null) "_id": id,
      };
}
