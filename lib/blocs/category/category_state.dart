import 'package:gavhar_app/data/models/category/category_model.dart';

abstract class CategoryState {}

class SuccessCategoryState extends CategoryState {
  List<CategoryModel> categories;

  SuccessCategoryState({required this.categories});
}

class LoadingCategoryState extends CategoryState {}

class ErrorCategoryState extends CategoryState {
  String errorText;

  ErrorCategoryState({required this.errorText});
}
