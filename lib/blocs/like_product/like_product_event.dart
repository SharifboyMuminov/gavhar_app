import 'package:gavhar_app/data/models/product/product_model.dart';

abstract class LikeProductEvent {}

class LikeProductCallEvent extends LikeProductEvent {}

class LikeProductInsertEvent extends LikeProductEvent {
  ProductModel productModel;

  LikeProductInsertEvent({required this.productModel});
}

class LikeProductDeleteEvent extends LikeProductEvent {
  ProductModel productModel;

  LikeProductDeleteEvent({required this.productModel});
}

class LikeProductDeleteForListEvent extends LikeProductEvent {
  List<ProductModel> productModels;

  LikeProductDeleteForListEvent({required this.productModels});
}
