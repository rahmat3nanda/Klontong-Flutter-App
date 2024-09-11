/*
 * *
 *  * seed.dart - klontong
 *  * Created by Rahmat Trinanda (rahmat3nanda@gmail.com) on 09/11/2024, 03:39
 *  * Copyright (c) 2024 . All rights reserved.
 *  * Last modified 09/11/2024, 03:38
 *
 */

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:klontong/data/API.dart';
import 'package:klontong/model/category_model.dart';
import 'package:klontong/model/product_model.dart';

String endpoint = "{{Your endpoint from crudcrud.com; example: 70d5a655bca443c590631cc03907b1d0}}";
String baseUrl = "https://crudcrud.com/api/$endpoint";
API api = API();
Dio dio = Dio();

void main() async {
  dio.options = BaseOptions(
    baseUrl: "$baseUrl/",
    headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
    },
  );

  await CategorySeeder.seed();
  await ProductSeeder.seed();
}

class CategorySeeder {
  static List<CategoryModel> data = [
    CategoryModel(name: "Drink"),
    CategoryModel(name: "Instant Foods"),
    CategoryModel(name: "Staple Foods"),
    CategoryModel(name: "Toiletries"),
    CategoryModel(name: "Snacks"),
  ];

  static Future<void> seed() async {
    // for (CategoryModel item in data) {
    for (int i = 0; i < data.length; i++) {
      Response res = await dio.post(api.category.data, data: data[i].toJson());
      CategoryModel result = CategoryModel.fromJson(res.data);
      data[i] = result;
    }
  }
}

class ProductSeeder {
  static List<ProductModel> data = [
    ProductModel(
      category: CategorySeeder.data.firstWhere((e) => e.name == "Drink"),
      sku: "a1",
      name: "UC-1000",
      description:
          "UC-1000 is a healthy vitamin drink that provides a refreshing way to boost your immune system with essential vitamins. Its compact bottle makes it convenient for on-the-go consumption.",
      weight: 0.5,
      width: 5.0,
      length: 5.0,
      height: 15.0,
      image:
          "https://images.tokopedia.net/img/cache/900/VqbcmM/2022/6/23/6d26406c-7d1d-4f21-a5f0-7b0c6947a78c.jpg",
      price: 10000,
    ),
    ProductModel(
      category: CategorySeeder.data.firstWhere((e) => e.name == "Drink"),
      sku: "a2",
      name: "Coca-Cola",
      description:
          "Coca-Cola is a world-famous soft drink with a refreshing cola flavor. It’s a perfect beverage to quench your thirst or complement your meals. Available in a handy 330 ml can.",
      weight: 0.33,
      width: 6.0,
      length: 6.0,
      height: 12.0,
      image:
          "https://images.tokopedia.net/img/cache/900/VqbcmM/2024/5/16/df6f6583-91db-48dc-ba34-52f61e299418.jpg",
      price: 8000,
    ),
    ProductModel(
      category: CategorySeeder.data.firstWhere((e) => e.name == "Drink"),
      sku: "a3",
      name: "Pepsi",
      description:
          "Pepsi is a popular cola-flavored soft drink that has been a favorite for decades. Its crisp and refreshing taste makes it perfect for any occasion.",
      weight: 0.33,
      width: 6.0,
      length: 6.0,
      height: 12.0,
      image:
          "https://images.tokopedia.net/img/cache/900/VqbcmM/2022/10/27/929c43dc-c6c4-40cc-8f92-8f3aebeed177.jpg",
      price: 7500,
    ),
    ProductModel(
      category:
          CategorySeeder.data.firstWhere((e) => e.name == "Instant Foods"),
      sku: "b1",
      name: "Indomie",
      description:
          "Indomie is a famous instant noodle brand that offers a rich flavor and quick cooking time. It’s a great choice for a quick and satisfying meal.",
      weight: 0.085,
      width: 8.0,
      length: 12.0,
      height: 3.0,
      image:
          "https://images.tokopedia.net/img/cache/900/hDjmkQ/2022/2/11/9c511231-c46f-4692-a7d5-c6473e00fc66.jpg",
      price: 2500,
    ),
    ProductModel(
      category:
          CategorySeeder.data.firstWhere((e) => e.name == "Instant Foods"),
      sku: "b2",
      name: "Pop Mie",
      description:
          "Pop Mie offers a convenient way to enjoy delicious noodles anytime and anywhere. Just add hot water, and it’s ready to eat in minutes.",
      weight: 0.1,
      width: 7.0,
      length: 7.0,
      height: 10.0,
      image:
          "https://images.tokopedia.net/img/cache/900/VqbcmM/2022/7/29/867a2e36-f9a3-483d-ac21-2be9df386bb9.png",
      price: 5000,
    ),
    ProductModel(
      category: CategorySeeder.data.firstWhere((e) => e.name == "Staple Foods"),
      sku: "c1",
      name: "Rice",
      description:
          "Premium quality rice that is perfect for daily meals. Its long grains and fragrant aroma ensure a delicious base for any dish.",
      weight: 5.0,
      width: 20.0,
      length: 30.0,
      height: 10.0,
      image:
          "https://images.tokopedia.net/img/cache/900/VqbcmM/2022/5/17/c51966f4-b8ee-41d0-86f7-2489879d8b3b.jpg",
      price: 50000,
    ),
    ProductModel(
      category: CategorySeeder.data.firstWhere((e) => e.name == "Staple Foods"),
      sku: "c2",
      name: "Sugar",
      description:
          "Refined sugar that is essential for sweetening beverages, desserts, and daily cooking.",
      weight: 1.0,
      width: 12.0,
      length: 18.0,
      height: 4.0,
      image:
          "https://images.tokopedia.net/img/cache/900/VqbcmM/2023/12/29/25b3a10c-15d7-4ce4-8aff-311e9dc162dd.jpg",
      price: 12000,
    ),
    ProductModel(
      category: CategorySeeder.data.firstWhere((e) => e.name == "Toiletries"),
      sku: "d1",
      name: "Toothpaste",
      description:
          "Fluoride toothpaste that helps protect teeth and maintain oral hygiene with a refreshing minty flavor.",
      weight: 0.1,
      width: 4.0,
      length: 6.0,
      height: 18.0,
      image:
          "https://images.tokopedia.net/img/cache/900/hDjmkQ/2024/6/10/23f464fa-8669-4164-915b-a6dc34fae09f.jpg",
      price: 15000,
    ),
    ProductModel(
      category: CategorySeeder.data.firstWhere((e) => e.name == "Toiletries"),
      sku: "d2",
      name: "Shampoo",
      description:
          "A high-quality hair care product designed to clean, nourish, and revitalize your hair. This shampoo is formulated with essential nutrients that help maintain healthy, shiny hair, while keeping it fresh and fragrant. Suitable for all hair types and ideal for daily use.",
      weight: 0.3,
      width: 7.0,
      length: 7.0,
      height: 18.0,
      image:
          "https://images.tokopedia.net/img/cache/900/hDjmkQ/2024/7/5/d6a6040d-1bcb-475c-b638-7e65f602927c.jpg",
      price: 25000,
    ),
    ProductModel(
      category: CategorySeeder.data.firstWhere((e) => e.name == "Toiletries"),
      sku: "d3",
      name: "Soap",
      description:
          "A gentle cleansing bar soap made to cleanse and moisturize your skin. Formulated with natural ingredients, this soap provides a refreshing experience, leaving your skin feeling soft and smooth. Ideal for all skin types, it creates a rich lather that gently removes dirt and impurities.",
      weight: 0.2,
      width: 8.0,
      length: 12.0,
      height: 3.0,
      image:
          "https://images.tokopedia.net/img/cache/900/VqbcmM/2022/3/31/ceaa4aad-d007-467c-8d16-cc4dabfba224.jpg",
      price: 5000,
    ),
    ProductModel(
      category: CategorySeeder.data.firstWhere((e) => e.name == "Snacks"),
      sku: "e1",
      name: "Potato Chips",
      description:
          "A pack of crispy, golden potato chips, fried to perfection and seasoned with just the right amount of salt. These crunchy snacks offer a satisfying and delicious treat, perfect for snacking on the go or sharing at gatherings. Great for any time of the day.",
      weight: 0.2,
      width: 10.0,
      length: 15.0,
      height: 4.0,
      image:
          "https://images.tokopedia.net/img/cache/900/VqbcmM/2021/11/27/b2534245-a181-4700-98c8-cc57958d1c8c.jpg",
      price: 15000,
    ),
    ProductModel(
      category: CategorySeeder.data.firstWhere((e) => e.name == "Snacks"),
      sku: "e2",
      name: "Chocolate Bar",
      description:
          "A delicious chocolate bar made from the finest cocoa beans, providing a rich, smooth, and creamy taste. This sweet treat is perfect for satisfying your chocolate cravings, whether you're enjoying it as a snack or a quick dessert. Conveniently packaged for on-the-go indulgence.",
      weight: 0.05,
      width: 4.0,
      length: 10.0,
      height: 2.0,
      image:
          "https://images.tokopedia.net/img/cache/900/VqbcmM/2021/2/10/6f17063d-723c-43dc-9f83-25fe5ce0c150.jpg",
      price: 10000,
    ),
    ProductModel(
      category: CategorySeeder.data.firstWhere((e) => e.name == "Snacks"),
      sku: "e3",
      name: "Biscuits",
      description:
          "Sweet, crunchy, and flavorful biscuits that make a perfect snack for any time of the day. These biscuits are baked to a golden crisp and have a delightful texture that pairs well with tea or coffee. They are an ideal snack for kids and adults alike, offering a tasty treat with every bite.",
      weight: 0.15,
      width: 12.0,
      length: 15.0,
      height: 5.0,
      image:
          "https://images.tokopedia.net/img/cache/900/VqbcmM/2024/6/11/855f1082-f49b-4254-a51d-0d009a85d961.jpg",
      price: 8000,
    ),
  ];

  static Future<void> seed() async {
    int page = -1;
    for (int i = 0; i < data.length; i++) {
      if (i % 10 == 0) {
        page++;
      }
      print(data[i].category?.id);
      Response res = await dio.post(
        api.product.data(page: page),
        data: data[i].toJson(),
      );
      ProductModel result = ProductModel.fromJson(res.data);
      data[i] = result;
    }
  }
}
