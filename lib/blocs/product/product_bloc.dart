import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gavhar_app/blocs/product/product_event.dart';
import 'package:gavhar_app/blocs/product/product_state.dart';
import 'package:gavhar_app/data/models/network_respons/network_respons_model.dart';
import 'package:gavhar_app/data/repositories/product_repository.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc(this.productRepository) : super(LoadingProductState()) {
    on<ProductCallEvent>(_callProduct);
  }

  final ProductRepository productRepository;

  Future<void> _callProduct(ProductCallEvent event, emit) async {
    emit(LoadingProductState());

    NetworkResponse networkResponse = await productRepository.getProducts();

    if (networkResponse.errorText.isEmpty) {
      emit(SuccessProductState(products: networkResponse.data));
    } else {
      emit(ErrorProductState(errorText: networkResponse.errorText));
    }
  }

  Future<void> _getProductForId(
      ProductGetForCategoryIdEvent event, emit) async {
    emit(LoadingProductState());

    NetworkResponse networkResponse =
        await productRepository.getProductForId(event.categoryId);

    if (networkResponse.errorText.isEmpty) {
      emit(SuccessProductState(products: networkResponse.data));
    } else {
      emit(ErrorProductState(errorText: networkResponse.errorText));
    }
  }
}
