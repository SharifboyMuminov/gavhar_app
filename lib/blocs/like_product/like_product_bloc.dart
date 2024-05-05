import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gavhar_app/blocs/like_product/like_product_event.dart';
import 'package:gavhar_app/blocs/like_product/like_product_state.dart';
import 'package:gavhar_app/data/enums/status_enum.dart';
import 'package:gavhar_app/data/models/network_respons/network_respons_model.dart';
import 'package:gavhar_app/data/models/product/product_model.dart';
import 'package:gavhar_app/data/sql_data/local_data.dart';

class LikeProductBloc extends Bloc<LikeProductEvent, LikeProductState> {
  LikeProductBloc()
      : super(LikeProductState(
          errorMessage: "",
          likeProducts: [],
          status: FromStatus.pure,
          statusMessage: '',
        )) {
    on<LikeProductCallEvent>(_callLikeProduct);
    on<LikeProductInsertEvent>(_insertLikeProduct);
    on<LikeProductDeleteEvent>(_deleteLikeProduct);
    on<LikeProductDeleteForListEvent>(_deleteLikeProductForList);
  }

  Future<void> _callLikeProduct(LikeProductCallEvent event, emit) async {
    emit(state.copyWith(status: FromStatus.loading));

    NetworkResponse networkResponse = NetworkResponse();

    networkResponse = await LocalDatabase.getAllDebtors();

    if (networkResponse.errorText.isEmpty) {
      emit(
        state.copyWith(
            status: FromStatus.success,
            likeProducts: networkResponse.data as List<ProductModel>),
      );
    } else {
      emit(
        state.copyWith(
          status: FromStatus.error,
        ),
      );
    }
  }

  Future<void> _insertLikeProduct(LikeProductInsertEvent event, emit) async {
    emit(state.copyWith(status: FromStatus.loading));

    NetworkResponse networkResponse = NetworkResponse();

    networkResponse = await LocalDatabase.insertDebtors(event.productModel);

    if (networkResponse.errorText.isEmpty) {
      add(LikeProductCallEvent());
    } else {
      emit(
        state.copyWith(
          status: FromStatus.error,
          statusMessage: "error",
        ),
      );
    }
  }

  Future<void> _deleteLikeProduct(LikeProductDeleteEvent event, emit) async {
    emit(state.copyWith(status: FromStatus.loading));

    NetworkResponse networkResponse = NetworkResponse();

    networkResponse = await LocalDatabase.deleteDebtors(event.productModel.id);

    if (networkResponse.errorText.isEmpty) {
      add(LikeProductCallEvent());
    } else {
      emit(
        state.copyWith(
          status: FromStatus.error,
          statusMessage: "error",
        ),
      );
    }
  }

  Future<void> _deleteLikeProductForList(
      LikeProductDeleteForListEvent event, emit) async {
    emit(state.copyWith(status: FromStatus.loading));

    NetworkResponse networkResponse = NetworkResponse();

    for (ProductModel productModel in event.productModels) {
      networkResponse = await LocalDatabase.deleteDebtors(productModel.id);
      if (networkResponse.errorText.isNotEmpty) {
        emit(
          state.copyWith(
            status: FromStatus.error,
            statusMessage: "error",
          ),
        );
        break;
      }
    }
    add(LikeProductCallEvent());
  }
}
