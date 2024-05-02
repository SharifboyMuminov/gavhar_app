import 'package:gavhar_app/data/models/product/product_model.dart';

abstract class ProductEvent {}

class ProductCallEvent extends ProductEvent {}

class ProductDeleteEvent extends ProductEvent {
  ProductModel productModel;

  ProductDeleteEvent({required this.productModel});
}

class ProductInsertEvent extends ProductEvent {
  ProductModel productModel;

  ProductInsertEvent({required this.productModel});
}

class ProductInsertForListEvent extends ProductEvent {
  List<ProductModel> productModels;

  ProductInsertForListEvent({required this.productModels});
}

class ProductUpdateEvent extends ProductEvent {
  ProductModel productModel;

  ProductUpdateEvent({required this.productModel});
}

class ProductGetForCategoryIdEvent extends ProductEvent {
  String categoryId;

  ProductGetForCategoryIdEvent({required this.categoryId});
}
