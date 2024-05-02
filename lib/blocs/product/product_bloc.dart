import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gavhar_app/blocs/product/product_event.dart';
import 'package:gavhar_app/blocs/product/product_state.dart';
import 'package:gavhar_app/data/models/network_respons/network_respons_model.dart';
import 'package:gavhar_app/data/repositories/product_repository.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc(this.productRepository) : super(LoadingProductState()) {
    on<ProductCallEvent>(_callProduct);
    on<ProductInsertEvent>(_insertProduct);
    on<ProductDeleteEvent>(_deleteProduct);
    on<ProductUpdateEvent>(_updateProduct);
    on<ProductInsertForListEvent>(_insertProductForList);
    on<ProductGetForCategoryIdEvent>(_getProductForId);
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

  Future<void> _insertProduct(ProductInsertEvent event, emit) async {
    emit(LoadingProductState());

    NetworkResponse networkResponse =
        await productRepository.insertProducts(event.productModel);

    if (networkResponse.errorText.isEmpty) {
      add(ProductCallEvent());
    } else {
      emit(ErrorProductState(errorText: networkResponse.errorText));
    }
  }

  Future<void> _deleteProduct(ProductDeleteEvent event, emit) async {
    emit(LoadingProductState());

    NetworkResponse networkResponse =
        await productRepository.deleteProducts(event.productModel);

    if (networkResponse.errorText.isEmpty) {
      add(ProductCallEvent());
    } else {
      emit(ErrorProductState(errorText: networkResponse.errorText));
    }
  }

  Future<void> _updateProduct(ProductUpdateEvent event, emit) async {
    emit(LoadingProductState());

    NetworkResponse networkResponse =
        await productRepository.updateProducts(event.productModel);

    if (networkResponse.errorText.isEmpty) {
      add(ProductCallEvent());
    } else {
      emit(ErrorProductState(errorText: networkResponse.errorText));
    }
  }

  _insertProductForList(ProductInsertForListEvent event, emit) async {
    emit(LoadingProductState());

    NetworkResponse networkResponse =
        await productRepository.insertProductForList(event.productModels);

    if (networkResponse.errorText.isEmpty) {
      emit(ProductShowSnackBarState(text: 'Malumotlar qaytarildi :)'));
      add(ProductCallEvent());
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
