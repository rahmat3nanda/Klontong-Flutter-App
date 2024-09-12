/*
 * *
 *  * category_field_dialog.dart - klontong
 *  * Created by Rahmat Trinanda (rahmat3nanda@gmail.com) on 09/12/2024, 14:27
 *  * Copyright (c) 2024 . All rights reserved.
 *  * Last modified 09/12/2024, 14:27
 *
 */

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:klontong/model/category_model.dart';

class CategoryFieldDialog extends StatefulWidget {
  final String action;
  final CategoryModel? category;

  const CategoryFieldDialog({
    super.key,
    required this.action,
    this.category,
  });

  @override
  State<CategoryFieldDialog> createState() => _CategoryFieldDialogState();
}

class _CategoryFieldDialogState extends State<CategoryFieldDialog> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.category?.name);
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoAlertDialog(
        title: _title(),
        content: CupertinoTextField(controller: _controller),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          CupertinoDialogAction(
            child: const Text("Save"),
            onPressed: () => Navigator.pop(context, _controller.text),
          ),
        ],
      );
    }
    return AlertDialog(
      title: _title(),
      content: TextField(controller: _controller),
      actions: [
        MaterialButton(
          child: const Text("Cancel"),
          onPressed: () => Navigator.pop(context),
        ),
        MaterialButton(
          child: const Text("Save"),
          onPressed: () => Navigator.pop(context, _controller.text),
        ),
      ],
    );
  }

  Widget _title() {
    return Text(
      "${widget.action} Category",
      style: const TextStyle(fontSize: 16.0),
    );
  }
}

Future openCategoryFieldDialog(
  BuildContext context, {
  required String action,
  CategoryModel? category,
}) {
  return showGeneralDialog(
    barrierLabel: "$action Category Dialog",
    barrierDismissible: true,
    barrierColor: Colors.black.withValues(alpha: 0.5),
    context: context,
    pageBuilder: (context, anim1, anim2) => CategoryFieldDialog(
      action: action,
      category: category,
    ),
    transitionDuration: const Duration(milliseconds: 100),
    transitionBuilder: (context, anim1, anim2, child) {
      return Transform.scale(
        scale: anim1.value,
        child: child,
      );
    },
  );
}
