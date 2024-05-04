import 'package:gavhar_app/data/models/product/product_model.dart';

abstract class ProductEvent {}

class ProductCallEvent extends ProductEvent {}

class ProductGetForCategoryIdEvent extends ProductEvent {
  String categoryId;

  ProductGetForCategoryIdEvent({required this.categoryId});
}
