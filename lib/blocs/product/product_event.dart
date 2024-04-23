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

class ProductUpdateEvent extends ProductEvent {
  ProductModel productModel;

  ProductUpdateEvent({required this.productModel});
}
