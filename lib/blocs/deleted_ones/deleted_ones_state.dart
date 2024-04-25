import 'package:gavhar_app/data/models/product/product_model.dart';

abstract class DeletedOnesState {}

class SuccessDeletedOnesState extends DeletedOnesState {
  List<ProductModel> products;

  SuccessDeletedOnesState({required this.products});
}

class LoadingDeletedOnesState extends DeletedOnesState {}

class ErrorDeletedOnesState extends DeletedOnesState {
  String errorText;

  ErrorDeletedOnesState({required this.errorText});
}
