/*
 * *
 *  * product_add_page.dart - klontong
 *  * Created by Rahmat Trinanda (rahmat3nanda@gmail.com) on 09/13/2024, 02:38
 *  * Copyright (c) 2024 . All rights reserved.
 *  * Last modified 09/13/2024, 02:38
 *  
 */

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:klontong/bloc/category/category_bloc.dart';
import 'package:klontong/bloc/product/product_bloc.dart';
import 'package:klontong/common/styles.dart';
import 'package:klontong/model/app/singleton_model.dart';
import 'package:klontong/model/category_model.dart';
import 'package:klontong/tool/helper.dart';
import 'package:klontong/widget/button_widget.dart';
import 'package:klontong/widget/loading_overlay.dart';

class ProductAddPage extends StatefulWidget {
  const ProductAddPage({super.key});

  @override
  State<ProductAddPage> createState() => _ProductAddPageState();
}

class _ProductAddPageState extends State<ProductAddPage> {
  late SingletonModel _model;
  late Helper _helper;
  late ProductBloc _productBloc;
  late CategoryBloc _categoryBloc;

  late GlobalKey<FormState> _formKey;
  late TextEditingController _cName;
  late TextEditingController _cSku;
  late TextEditingController _cDescription;
  late TextEditingController _cWeight;
  late TextEditingController _cWidth;
  late TextEditingController _cLength;
  late TextEditingController _cHeight;
  late TextEditingController _cPrice;
  late TextEditingController _cImage;
  CategoryModel? _category;
  late bool _canSend;
  late bool _onSave;

  @override
  void initState() {
    super.initState();
    _model = SingletonModel.withContext(context);
    _helper = Helper();
    _productBloc = BlocProvider.of<ProductBloc>(context);
    _categoryBloc = BlocProvider.of<CategoryBloc>(context);
    _formKey = GlobalKey();
    _cName = TextEditingController();
    _cSku = TextEditingController();
    _cDescription = TextEditingController();
    _cWeight = TextEditingController();
    _cWidth = TextEditingController();
    _cLength = TextEditingController();
    _cHeight = TextEditingController();
    _cPrice = TextEditingController();
    _cImage = TextEditingController();
    _canSend = false;
    _onSave = false;
    _categoryBloc.add(const CategoryDataEvent());
  }

  void _onTapOutside(PointerDownEvent e) {
    FocusScope.of(context).unfocus();
  }

  void _onChange(String? s) {
    setState(() {
      _canSend = _cName.text.trim().isNotEmpty &&
          _category != null &&
          _cWeight.text.trim().isNotEmpty &&
          _cWidth.text.trim().isNotEmpty &&
          _cLength.text.trim().isNotEmpty &&
          _cHeight.text.trim().isNotEmpty &&
          _cPrice.text.trim().isNotEmpty &&
          _cSku.text.trim().isNotEmpty &&
          _cDescription.text.trim().isNotEmpty;
    });
  }

  void _onSubmit() {
    FocusScope.of(context).unfocus();

    if (_cName.text.trim().isEmpty) {
      _helper.showToast("Name cannot be empty!");
      return;
    }
    if (_category == null) {
      _helper.showToast("Category cannot be empty!");
      return;
    }
    if (_cSku.text.trim().isEmpty) {
      _helper.showToast("SKU cannot be empty!");
      return;
    }
    if (_cDescription.text.trim().isEmpty) {
      _helper.showToast("Description cannot be empty!");
      return;
    }
    if (_cWeight.text.trim().isEmpty) {
      _helper.showToast("Weight cannot be empty!");
      return;
    }
    if (_cLength.text.trim().isEmpty) {
      _helper.showToast("Length cannot be empty!");
      return;
    }
    if (_cHeight.text.trim().isEmpty) {
      _helper.showToast("Height cannot be empty!");
      return;
    }
    if (_cPrice.text.trim().isEmpty) {
      _helper.showToast("Price cannot be empty!");
      return;
    }

    if (_formKey.currentState?.validate() ?? false) {
      _onSave = true;
      _productBloc.add(ProductCreateEvent(
        category: _category!,
        sku: _cSku.text.trim(),
        name: _cName.text.trim(),
        description: _cDescription.text.trim(),
        weight: double.tryParse(_cWeight.text.trim()) ?? 0,
        width: double.tryParse(_cWidth.text.trim()) ?? 0,
        length: double.tryParse(_cLength.text.trim()) ?? 0,
        height: double.tryParse(_cHeight.text.trim()) ?? 0,
        image: _cImage.text.trim(),
        price: int.tryParse(_cPrice.text.trim()) ?? 0,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    _onSave = false;
    return MultiBlocListener(
      listeners: [
        BlocListener(
          bloc: _productBloc,
          listener: (c, s) {
            if (s is ProductCreateSuccessState) {
              _onSave = false;
              _helper.showToast("Success create Product");
              // Navigator.pop(context, true);
            } else if (s is ProductCreateFailedState) {
              _onSave = false;
              _helper.showToast("Failure create Product.\n${s.data.message}");
            }
          },
        ),
        BlocListener(
          bloc: _categoryBloc,
          listener: (c, s) {
            if (s is CategoryDataSuccessState) {
              setState(() {
                _model = SingletonModel.withContext(context);
              });
            }
          },
        ),
      ],
      child: BlocBuilder(
        bloc: _productBloc,
        builder: (c, s) {
          return Scaffold(
            appBar: AppBar(title: const Text("Create Product")),
            body: LoadingOverlay(
              isLoading: _onSave,
              color: Colors.white.withOpacity(0.6),
              progressIndicator: SpinKitWaveSpinner(
                color: AppColor.primaryLight,
                trackColor: AppColor.primary,
                waveColor: AppColor.secondary,
                size: 64,
              ),
              child: SafeArea(child: _mainView()),
            ),
          );
        },
      ),
    );
  }

  Widget _mainView() {
    return Column(
      children: [
        Expanded(child: _formView()),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ButtonWidget(
            isActive: _canSend,
            onTap: _onSubmit,
            width: double.infinity,
            child: const Center(
              child: Text(
                "Save",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _formView() {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        children: [
          TextFormField(
            textInputAction: TextInputAction.next,
            controller: _cName,
            textCapitalization: TextCapitalization.words,
            keyboardType: TextInputType.name,
            onChanged: _onChange,
            style: TextStyle(
              color: AppColor.primary,
              fontWeight: FontWeight.w700,
            ),
            decoration: const InputDecoration(hintText: "Name"),
          ),
          const SizedBox(height: 16),
          DropdownSearch<CategoryModel>(
            popupProps: PopupProps.menu(
              showSearchBox: true,
              isFilterOnline: true,
              searchFieldProps: TextFieldProps(
                autocorrect: false,
                decoration: InputDecoration(
                  hintText: "Search Category",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(width: 1, color: AppColor.primary),
                  ),
                ),
              ),
              loadingBuilder: (c, s) => Center(
                child: SpinKitWaveSpinner(
                  color: AppColor.primaryLight,
                  trackColor: AppColor.primary,
                  waveColor: AppColor.secondary,
                ),
              ),
              emptyBuilder: (c, s) => Center(
                child: Text("Could not find \"$s\"."),
              ),
              errorBuilder: (c, s, a) => Center(
                child: Text("$a".contains("type 'String")
                    ? "Cound not find \"$s\"."
                    : "Something when wrong"),
              ),
            ),
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: const InputDecoration(
                hintText: "Category",
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 24.0,
                ),
              ),
              baseStyle: TextStyle(
                fontSize: 16,
                color: AppColor.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
            asyncItems: (s) async {
              return (_model.categories ?? [])
                  .where((e) =>
                      e.name?.toLowerCase().contains(s.trim().toLowerCase()) ??
                      false)
                  .toList();
            },
            selectedItem: _category,
            itemAsString: (d) => d.name ?? "",
            onChanged: (d) => setState(() {
              _category = d;
              _onChange(null);
            }),
          ),
          const SizedBox(height: 16),
          TextFormField(
            textInputAction: TextInputAction.next,
            controller: _cSku,
            textCapitalization: TextCapitalization.words,
            keyboardType: TextInputType.name,
            onChanged: _onChange,
            style: TextStyle(
              color: AppColor.primary,
              fontWeight: FontWeight.w700,
            ),
            decoration: const InputDecoration(hintText: "SKU"),
          ),
          const SizedBox(height: 16),
          TextFormField(
            textInputAction: TextInputAction.newline,
            minLines: 2,
            maxLines: 5,
            controller: _cDescription,
            textCapitalization: TextCapitalization.words,
            keyboardType: TextInputType.multiline,
            onChanged: _onChange,
            style: TextStyle(
              color: AppColor.primary,
              fontWeight: FontWeight.w700,
            ),
            decoration: const InputDecoration(hintText: "Description"),
          ),
          const SizedBox(height: 16),
          TextFormField(
            textInputAction: TextInputAction.next,
            controller: _cWeight,
            onTapOutside: _onTapOutside,
            textCapitalization: TextCapitalization.words,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: _onChange,
            style: TextStyle(
              color: AppColor.primary,
              fontWeight: FontWeight.w700,
            ),
            decoration: const InputDecoration(
              hintText: "Weight",
              suffix: Text("KG"),
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            textInputAction: TextInputAction.next,
            controller: _cWidth,
            onTapOutside: _onTapOutside,
            textCapitalization: TextCapitalization.words,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: _onChange,
            style: TextStyle(
              color: AppColor.primary,
              fontWeight: FontWeight.w700,
            ),
            decoration: const InputDecoration(
              hintText: "Width",
              suffix: Text("cm"),
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            textInputAction: TextInputAction.next,
            controller: _cLength,
            onTapOutside: _onTapOutside,
            textCapitalization: TextCapitalization.words,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: _onChange,
            style: TextStyle(
              color: AppColor.primary,
              fontWeight: FontWeight.w700,
            ),
            decoration: const InputDecoration(
              hintText: "Length",
              suffix: Text("cm"),
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            textInputAction: TextInputAction.next,
            controller: _cHeight,
            onTapOutside: _onTapOutside,
            textCapitalization: TextCapitalization.words,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: _onChange,
            style: TextStyle(
              color: AppColor.primary,
              fontWeight: FontWeight.w700,
            ),
            decoration: const InputDecoration(
              hintText: "Height",
              suffix: Text("cm"),
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            textInputAction: TextInputAction.next,
            controller: _cPrice,
            onTapOutside: _onTapOutside,
            textCapitalization: TextCapitalization.words,
            keyboardType: TextInputType.number,
            onChanged: _onChange,
            style: TextStyle(
              color: AppColor.primary,
              fontWeight: FontWeight.w700,
            ),
            decoration: const InputDecoration(
              hintText: "Price",
              prefix: Text("RP."),
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            textInputAction: TextInputAction.done,
            controller: _cImage,
            onTapOutside: _onTapOutside,
            textCapitalization: TextCapitalization.none,
            keyboardType: TextInputType.url,
            onChanged: _onChange,
            style: TextStyle(
              color: AppColor.primary,
              fontWeight: FontWeight.w700,
            ),
            decoration: const InputDecoration(hintText: "Image URL"),
          ),
        ],
      ),
    );
  }
}
