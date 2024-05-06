import 'package:gavhar_app/data/models/product/product_model.dart';

abstract class BasketEvent {}

class AddProductToBasketEvent extends BasketEvent {
  ProductModel productModel;

  AddProductToBasketEvent({required this.productModel});
}

class RemoveProductInBasketEvent extends BasketEvent {
  ProductModel productModel;

  RemoveProductInBasketEvent({required this.productModel});
}

class UpdateProductBasketEvent extends BasketEvent {
  ProductModel productModel;

  UpdateProductBasketEvent({required this.productModel});
}

class RemoveProductInBasketForListEvent extends BasketEvent {
  ProductModel productModel;

  RemoveProductInBasketForListEvent({required this.productModel});
}
