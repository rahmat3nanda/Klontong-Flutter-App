/*
 * *
 *  * product_event.dart - klontong
 *  * Created by Rahmat Trinanda (rahmat3nanda@gmail.com) on 09/12/2024, 18:49
 *  * Copyright (c) 2024 . All rights reserved.
 *  * Last modified 09/12/2024, 02:39
 *  
 */

import 'package:equatable/equatable.dart';
import 'package:klontong/model/category_model.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class ProductDataEvent extends ProductEvent {
  final int page;

  const ProductDataEvent(this.page);

  @override
  String toString() {
    return 'ProductDataEvent{page: $page}';
  }
}

class ProductCreateEvent extends ProductEvent {
  final CategoryModel category;
  final String sku;
  final String name;
  final String description;
  final double weight;
  final double width;
  final double length;
  final double height;
  final String image;
  final int price;

  const ProductCreateEvent({
    required this.category,
    required this.sku,
    required this.name,
    required this.description,
    required this.weight,
    required this.width,
    required this.length,
    required this.height,
    required this.image,
    required this.price,
  });

  @override
  String toString() {
    return 'ProductCreateEvent{category: $category, sku: $sku, name: $name, description: $description, weight: $weight, width: $width, length: $length, height: $height, image: $image, price: $price}';
  }
}

class ProductDetailEvent extends ProductEvent {
  final String id;

  const ProductDetailEvent(this.id);

  @override
  String toString() {
    return 'ProductDetailEvent{id: $id}';
  }
}

class ProductUpdateEvent extends ProductEvent {
  final String id;
  final CategoryModel category;
  final String sku;
  final String name;
  final String description;
  final double weight;
  final double width;
  final double length;
  final double height;
  final String image;
  final int price;

  const ProductUpdateEvent({
    required this.id,
    required this.category,
    required this.sku,
    required this.name,
    required this.description,
    required this.weight,
    required this.width,
    required this.length,
    required this.height,
    required this.image,
    required this.price,
  });

  @override
  String toString() {
    return 'ProductUpdateEvent{id: $id, category: $category, sku: $sku, name: $name, description: $description, weight: $weight, width: $width, length: $length, height: $height, image: $image, price: $price}';
  }
}

class ProductDeleteEvent extends ProductEvent {
  final String id;

  const ProductDeleteEvent(this.id);

  @override
  String toString() {
    return 'ProductDeleteEvent{id: $id}';
  }
}
