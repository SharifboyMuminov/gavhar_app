import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gavhar_app/blocs/category/category_event.dart';
import 'package:gavhar_app/blocs/category/category_state.dart';
import 'package:gavhar_app/data/local/local_varibals.dart';
import 'package:gavhar_app/data/models/category/category_model.dart';
import 'package:gavhar_app/data/models/network_respons/network_respons_model.dart';
import 'package:gavhar_app/data/repositories/category_repository.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc(this.categoryRepository) : super(LoadingCategoryState()) {
    on<CategoryCallEvent>(_callProduct);
    on<CategoryInsertEvent>(_insertProduct);
    on<CategoryDeleteEvent>(_deleteProduct);
    on<CategoryUpdateEvent>(_updateProduct);
  }

  final CategoryRepository categoryRepository;

  Future<void> _callProduct(CategoryCallEvent event, emit) async {
    // debugPrint("asdfadsf");
    emit(LoadingCategoryState());
    NetworkResponse networkResponse = await categoryRepository.getCategories();

    if (networkResponse.errorText.isEmpty) {
      globalCategories = networkResponse.data;

      emit(SuccessCategoryState(
          categories: networkResponse.data as List<CategoryModel>));
    } else {
      emit(ErrorCategoryState(errorText: networkResponse.errorText));
    }
  }

  Future<void> _insertProduct(CategoryInsertEvent event, emit) async {
    emit(LoadingCategoryState());

    NetworkResponse networkResponse =
        await categoryRepository.insertCategory(event.categoryModel);

    if (networkResponse.errorText.isEmpty) {
      add(CategoryCallEvent());
    } else {
      emit(ErrorCategoryState(errorText: networkResponse.errorText));
    }
  }

  Future<void> _deleteProduct(CategoryDeleteEvent event, emit) async {
    emit(LoadingCategoryState());

    NetworkResponse networkResponse =
        await categoryRepository.deleteCategory(event.categoryModel);

    if (networkResponse.errorText.isEmpty) {
      add(CategoryCallEvent());
    } else {
      emit(ErrorCategoryState(errorText: networkResponse.errorText));
    }
  }

  Future<void> _updateProduct(CategoryUpdateEvent event, emit) async {
    emit(LoadingCategoryState());

    NetworkResponse networkResponse =
        await categoryRepository.updateCategory(event.categoryModel);

    if (networkResponse.errorText.isEmpty) {
      add(CategoryCallEvent());
    } else {
      emit(ErrorCategoryState(errorText: networkResponse.errorText));
    }
  }
}
