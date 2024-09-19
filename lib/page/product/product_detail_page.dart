/*
 * *
 *  * product_detail_page.dart - klontong
 *  * Created by Rahmat Trinanda (rahmat3nanda@gmail.com) on 09/13/2024, 01:37
 *  * Copyright (c) 2024 . All rights reserved.
 *  * Last modified 09/13/2024, 01:07
 *  
 */

import 'package:flutter/material.dart';
import 'package:klontong/common/styles/app_color.dart';
import 'package:klontong/model/product_model.dart';
import 'package:klontong/tool/helper.dart';
import 'package:klontong/widget/image_network_widget.dart';

class ProductDetailPage extends StatefulWidget {
  final ProductModel item;

  const ProductDetailPage({super.key, required this.item});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 250.0,
              automaticallyImplyLeading: true,
              floating: false,
              pinned: true,
              flexibleSpace: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  var top = constraints.biggest.height;
                  var opacity =
                      (1 - (top - kToolbarHeight) / 200).clamp(0.0, 1.0);

                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      ImageNetworkWidget(url: widget.item.image ?? ""),
                      Container(
                        color: Colors.white.withOpacity(opacity),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          color: AppColor.primary
                              .withOpacity(0.6 * (1 - opacity)),
                          height: kToolbarHeight,
                          padding: EdgeInsets.only(
                            right: 16,
                            left: 16 + (56 * opacity),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.item.name ?? "",
                                style: TextStyle(
                                  color: Color.lerp(
                                      Colors.white, Colors.black, opacity),
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: _mainView(),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _mainView() {
    ProductModel d = widget.item;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(d.price.toMoney()),
        const SizedBox(height: 12),
        Text(d.description ?? ""),
        const SizedBox(height: 16),
        Text("Category: ${d.category?.name ?? "-"}"),
        const SizedBox(height: 4),
        Text("SKU: ${d.sku ?? "-"}"),
        const SizedBox(height: 4),
        Text(
            "Dimension: ${d.length ?? "-"} cm x ${d.width ?? "-"} cm x ${d.height ?? "-"} cm"),
        const SizedBox(height: 4),
        Text("Weight: ${d.weight ?? "-"} KG"),
      ],
    );
  }
}
