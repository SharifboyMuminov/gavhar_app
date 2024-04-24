import 'package:gavhar_app/data/models/category/category_model.dart';

abstract class CategoryEvent {}

class CategoryCallEvent extends CategoryEvent {}

class CategoryDeleteEvent extends CategoryEvent {
  CategoryModel categoryModel;

  CategoryDeleteEvent({required this.categoryModel});
}

class CategoryInsertEvent extends CategoryEvent {
  CategoryModel categoryModel;

  CategoryInsertEvent({required this.categoryModel});
}

class CategoryUpdateEvent extends CategoryEvent {
  CategoryModel categoryModel;

  CategoryUpdateEvent({required this.categoryModel});
}
