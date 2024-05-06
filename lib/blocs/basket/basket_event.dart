import 'package:gavhar_app/data/models/product/product_model.dart';

abstract class BasketEvent {}

class AddProductToBasketEvent extends BasketEvent {
  ProductModel productModel;

  AddProductToBasketEvent({required this.productModel});
}

class DeleteProductInBasketEvent extends BasketEvent {
  ProductModel productModel;

  DeleteProductInBasketEvent({required this.productModel});
}

class UpdateProductBasketEvent extends BasketEvent {
  ProductModel productModel;

  UpdateProductBasketEvent({required this.productModel});
}

class DeleteProductInBasketForListEvent extends BasketEvent {
  ProductModel productModel;

  DeleteProductInBasketForListEvent({required this.productModel});
}

class CallBasketProductsEvent extends BasketEvent {}
