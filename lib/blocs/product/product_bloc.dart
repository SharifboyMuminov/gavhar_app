import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gavhar_app/blocs/product/product_event.dart';
import 'package:gavhar_app/blocs/product/product_state.dart';
import 'package:gavhar_app/data/models/product/product_model.dart';
import 'package:gavhar_app/utils/app_constans/app_constans.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(LoadingProductState()) {
    on<ProductCallEvent>(_callProduct);
    on<ProductInsertEvent>(_insertProduct);
    on<ProductDeleteEvent>(_deleteProduct);
    on<ProductUpdateEvent>(_updateProduct);
  }

  Future<void> _callProduct(ProductCallEvent event, emit) async {
    // debugPrint("asdfadsf");
    emit(LoadingProductState());
    List<ProductModel> products = [];

    try {
      await FirebaseFirestore.instance
          .collection(AppConst.productTableName)
          .get()
          .then((value) {
        products =
            value.docs.map((e) => ProductModel.fromJson(e.data())).toList();
        // debugPrint("product --------${products}");
      });
      emit(SuccessProductState(products: products));
    } on FirebaseException catch (_) {
      emit(ErrorProductState(errorText: "on FirebaseException catch (_)"));
    } catch (_) {
      emit(ErrorProductState(errorText: "catch (_)"));
    }
  }

  Future<void> _insertProduct(ProductInsertEvent event, emit) async {
    emit(LoadingProductState());

    try {
      final cf = await FirebaseFirestore.instance
          .collection(AppConst.productTableName)
          .add(event.productModel.toJson());
      await FirebaseFirestore.instance
          .collection(AppConst.productTableName)
          .doc(cf.id)
          .update({"doc_id": cf.id});
      add(ProductCallEvent());
    } on FirebaseException catch (_) {
      // debugPrint("Error insertProduct on FirebaseException catch (_)");
      emit(ErrorProductState(errorText: "on FirebaseException catch (_)"));
    } catch (_) {
      // debugPrint("Error insertProduct catch (_)");
      emit(ErrorProductState(errorText: "catch (_)"));
    }
  }

  Future<void> _deleteProduct(ProductDeleteEvent event, emit) async {
    emit(LoadingProductState());

    try {
      await FirebaseFirestore.instance
          .collection(AppConst.productTableName)
          .doc(event.productModel.docId)
          .delete();

      add(ProductCallEvent());
    } on FirebaseException catch (_) {
      // debugPrint("Error insertProduct on FirebaseException catch (_)");
      emit(ErrorProductState(errorText: "on FirebaseException catch (_)"));
    } catch (_) {
      // debugPrint("Error insertProduct catch (_)");
      emit(ErrorProductState(errorText: "catch (_)"));
    }
  }

  Future<void> _updateProduct(ProductUpdateEvent event, emit) async {
    emit(LoadingProductState());

    try {
      await FirebaseFirestore.instance
          .collection(AppConst.productTableName)
          .doc(event.productModel.docId)
          .update(event.productModel.toJson());

      add(ProductCallEvent());
    } on FirebaseException catch (_) {
      // debugPrint("Error insertProduct on FirebaseException catch (_)");
      emit(ErrorProductState(errorText: "on FirebaseException catch (_)"));
    } catch (_) {
      // debugPrint("Error insertProduct catch (_)");
      emit(ErrorProductState(errorText: "catch (_)"));
    }
  }
}
