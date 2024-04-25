import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gavhar_app/blocs/deleted_ones/deleted_ones_event.dart';
import 'package:gavhar_app/blocs/deleted_ones/deleted_ones_state.dart';
import 'package:gavhar_app/data/models/product/product_model.dart';
import 'package:gavhar_app/utils/app_constans/app_constans.dart';

class DeletedOnesBloc extends Bloc<DeletedOnesEvent, DeletedOnesState> {
  DeletedOnesBloc() : super(LoadingDeletedOnesState()) {
    on<DeletedOnesCallEvent>(_callProduct);
    on<DeletedOnesInsertEvent>(_insertProduct);
    on<DeletedOnesDeleteEvent>(_deleteProduct);
  }

  Future<void> _callProduct(DeletedOnesCallEvent event, emit) async {
    // debugPrint("asdfadsf");
    emit(LoadingDeletedOnesState());
    List<ProductModel> products = [];

    try {
      await FirebaseFirestore.instance
          .collection(AppConst.productDeletedOnesTableName)
          .get()
          .then((value) {
        products =
            value.docs.map((e) => ProductModel.fromJson(e.data())).toList();
        // debugPrint("product --------${products}");
      });
      emit(SuccessDeletedOnesState(products: products));
    } on FirebaseException catch (_) {
      emit(ErrorDeletedOnesState(errorText: "on FirebaseException catch (_)"));
    } catch (_) {
      emit(ErrorDeletedOnesState(errorText: "catch (_)"));
    }
  }

  Future<void> _insertProduct(DeletedOnesInsertEvent event, emit) async {
    emit(LoadingDeletedOnesState());

    try {
      final cf = await FirebaseFirestore.instance
          .collection(AppConst.productDeletedOnesTableName)
          .add(event.productModel.toJson());
      await FirebaseFirestore.instance
          .collection(AppConst.productDeletedOnesTableName)
          .doc(cf.id)
          .update({"doc_id": cf.id});
      add(DeletedOnesCallEvent());
    } on FirebaseException catch (_) {
      // debugPrint("Error insertProduct on FirebaseException catch (_)");
      emit(ErrorDeletedOnesState(errorText: "on FirebaseException catch (_)"));
    } catch (_) {
      // debugPrint("Error insertProduct catch (_)");
      emit(ErrorDeletedOnesState(errorText: "catch (_)"));
    }
  }

  Future<void> _deleteProduct(DeletedOnesDeleteEvent event, emit) async {
    emit(LoadingDeletedOnesState());

    try {
      await FirebaseFirestore.instance
          .collection(AppConst.productDeletedOnesTableName)
          .doc(event.productModel.docId)
          .delete();

      add(DeletedOnesCallEvent());
    } on FirebaseException catch (_) {
      // debugPrint("Error insertProduct on FirebaseException catch (_)");
      emit(ErrorDeletedOnesState(errorText: "on FirebaseException catch (_)"));
    } catch (_) {
      // debugPrint("Error insertProduct catch (_)");
      emit(ErrorDeletedOnesState(errorText: "catch (_)"));
    }
  }
}
