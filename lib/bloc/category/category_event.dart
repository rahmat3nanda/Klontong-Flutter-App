/*
 * *
 *  * category_event.dart - klontong
 *  * Created by Rahmat Trinanda (rahmat3nanda@gmail.com) on 09/11/2024, 13:27
 *  * Copyright (c) 2024 . All rights reserved.
 *  * Last modified 09/11/2024, 13:27
 *
 */

import 'package:equatable/equatable.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class CategoryDataEvent extends CategoryEvent {
  const CategoryDataEvent();

  @override
  String toString() {
    return "CategoryDataEvent{}";
  }
}

class CategoryCreateEvent extends CategoryEvent {
  final String name;

  const CategoryCreateEvent({required this.name});

  @override
  String toString() {
    return 'CategoryCreateEvent{name: $name}';
  }
}

class CategoryDetailEvent extends CategoryEvent {
  final String id;

  const CategoryDetailEvent(this.id);

  @override
  String toString() {
    return 'CategoryDetailEvent{id: $id}';
  }
}

class CategoryUpdateEvent extends CategoryEvent {
  final String id;
  final String name;

  const CategoryUpdateEvent({required this.id, required this.name});

  @override
  String toString() {
    return 'CategoryUpdateEvent{id: $id, name: $name}';
  }
}

class CategoryDeleteEvent extends CategoryEvent {
  final String id;

  const CategoryDeleteEvent(this.id);

  @override
  String toString() {
    return 'CategoryDeleteEvent{id: $id}';
  }
}
