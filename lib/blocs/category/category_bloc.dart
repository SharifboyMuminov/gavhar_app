import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gavhar_app/blocs/category/category_event.dart';
import 'package:gavhar_app/blocs/category/category_state.dart';
import 'package:gavhar_app/data/models/category/category_model.dart';
import 'package:gavhar_app/utils/app_constans/app_constans.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(LoadingCategoryState()) {
    on<CategoryCallEvent>(_callProduct);
    on<CategoryInsertEvent>(_insertProduct);
    on<CategoryDeleteEvent>(_deleteProduct);
    on<CategoryUpdateEvent>(_updateProduct);
  }

  Future<void> _callProduct(CategoryCallEvent event, emit) async {
    // debugPrint("asdfadsf");
    emit(LoadingCategoryState());
    List<CategoryModel> categories = [];

    try {
      await FirebaseFirestore.instance
          .collection(AppConst.categoryTableName)
          .get()
          .then((value) {
        categories =
            value.docs.map((e) => CategoryModel.fromJson(e.data())).toList();
        // debugPrint("product --------${products}");
      });
      emit(SuccessCategoryState(categories: categories));
    } on FirebaseException catch (_) {
      emit(ErrorCategoryState(errorText: "on FirebaseException catch (_)"));
    } catch (_) {
      emit(ErrorCategoryState(errorText: "catch (_)"));
    }
  }

  Future<void> _insertProduct(CategoryInsertEvent event, emit) async {
    emit(LoadingCategoryState());

    try {
      final cf = await FirebaseFirestore.instance
          .collection(AppConst.categoryTableName)
          .add(event.categoryModel.toJson());
      await FirebaseFirestore.instance
          .collection(AppConst.categoryTableName)
          .doc(cf.id)
          .update({"doc_id": cf.id});
      add(CategoryCallEvent());
    } on FirebaseException catch (_) {
      // debugPrint("Error insertProduct on FirebaseException catch (_)");
      emit(ErrorCategoryState(errorText: "on FirebaseException catch (_)"));
    } catch (_) {
      // debugPrint("Error insertProduct catch (_)");
      emit(ErrorCategoryState(errorText: "catch (_)"));
    }
  }

  Future<void> _deleteProduct(CategoryDeleteEvent event, emit) async {
    emit(LoadingCategoryState());

    try {
      await FirebaseFirestore.instance
          .collection(AppConst.categoryTableName)
          .doc(event.categoryModel.docId)
          .delete();

      add(CategoryCallEvent());
    } on FirebaseException catch (_) {
      // debugPrint("Error insertProduct on FirebaseException catch (_)");
      emit(ErrorCategoryState(errorText: "on FirebaseException catch (_)"));
    } catch (_) {
      // debugPrint("Error insertProduct catch (_)");
      emit(ErrorCategoryState(errorText: "catch (_)"));
    }
  }

  Future<void> _updateProduct(CategoryUpdateEvent event, emit) async {
    emit(LoadingCategoryState());

    try {
      await FirebaseFirestore.instance
          .collection(AppConst.categoryTableName)
          .doc(event.categoryModel.docId)
          .update(event.categoryModel.toJson());

      add(CategoryCallEvent());
    } on FirebaseException catch (_) {
      // debugPrint("Error insertProduct on FirebaseException catch (_)");
      emit(ErrorCategoryState(errorText: "on FirebaseException catch (_)"));
    } catch (_) {
      // debugPrint("Error insertProduct catch (_)");
      emit(ErrorCategoryState(errorText: "catch (_)"));
    }
  }
}
