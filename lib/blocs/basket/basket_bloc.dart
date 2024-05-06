import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gavhar_app/blocs/basket/basket_event.dart';
import 'package:gavhar_app/blocs/basket/basket_state.dart';
import 'package:gavhar_app/data/enums/status_enum.dart';
import 'package:gavhar_app/data/models/network_respons/network_respons_model.dart';
import 'package:gavhar_app/data/models/product/product_model.dart';
import 'package:gavhar_app/data/sql_data/local_data.dart';

class BasketProductBloc extends Bloc<BasketEvent, BasketState> {
  BasketProductBloc()
      : super(
          BasketState(
              errorStatus: "",
              products: [],
              fromStatus: FromStatus.pure,
              errorString: ""),
        ) {
    on<AddProductToBasketEvent>(_insertToBasketProduct);
    on<CallBasketProductsEvent>(_callCallBasketProducts);
    on<DeleteProductInBasketEvent>(_deleteProduct);
  }

  Future<void> _insertToBasketProduct(
      AddProductToBasketEvent event, emit) async {
    emit(state.copyWith(fromStatus: FromStatus.loading));

    for (ProductModel pro in state.products) {
      if (pro.docId == event.productModel.docId) {
        add(UpdateProductBasketEvent(
            productModel: pro.copyWith(count: pro.count + 1)));
        return;
      }
    }

    NetworkResponse networkResponse =
        await LocalDatabase.insertToBasketProdeuct(event.productModel);

    if (networkResponse.errorText.isEmpty) {
      add(CallBasketProductsEvent());
      emit(state.copyWith(fromStatus: FromStatus.success));
    } else {
      emit(state.copyWith(
          fromStatus: FromStatus.error,
          errorString: networkResponse.errorText));
    }
  }

  Future<void> _callCallBasketProducts(
      CallBasketProductsEvent event, emit) async {
    emit(state.copyWith(fromStatus: FromStatus.loading));

    NetworkResponse networkResponse =
        await LocalDatabase.getAllBasketProducts();

    if (networkResponse.errorText.isEmpty) {
      emit(state.copyWith(
          fromStatus: FromStatus.success, products: networkResponse.data));
    } else {
      emit(state.copyWith(
          fromStatus: FromStatus.error,
          errorString: networkResponse.errorText));
    }
  }

  Future<void> _deleteProduct(DeleteProductInBasketEvent event, emit) async {
    emit(state.copyWith(fromStatus: FromStatus.loading));

    NetworkResponse networkResponse =
        await LocalDatabase.deleteDebtors(event.productModel.docId);

    if (networkResponse.errorText.isEmpty) {
      add(CallBasketProductsEvent());
      emit(state.copyWith(fromStatus: FromStatus.success));
    } else {
      emit(state.copyWith(
          fromStatus: FromStatus.error,
          errorString: networkResponse.errorText));
    }
  }
}
