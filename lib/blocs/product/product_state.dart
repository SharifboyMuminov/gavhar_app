import 'dart:ui';

import 'package:gavhar_app/data/models/product/product_model.dart';

abstract class ProductState {}

class SuccessProductState extends ProductState {
  List<ProductModel> products;

  SuccessProductState({required this.products});
}

class LoadingProductState extends ProductState {}

class ErrorProductState extends ProductState {
  String errorText;

  ErrorProductState({required this.errorText});
}

class ProductShowSnackBarState extends ProductState {
  String text;
  Color? color;

  ProductShowSnackBarState({required this.text, this.color});
}
