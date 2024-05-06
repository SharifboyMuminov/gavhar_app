import 'package:gavhar_app/data/enums/status_enum.dart';
import 'package:gavhar_app/data/models/product/product_model.dart';

class BasketState {
  final String errorString;
  final String errorStatus;
  final FromStatus fromStatus;
  final List<ProductModel> products;

  BasketState(
      {required this.errorStatus,
      required this.products,
      required this.fromStatus,
      required this.errorString});

  BasketState copyWith({
    String? errorString,
    String? errorStatus,
    FromStatus? fromStatus,
    List<ProductModel>? products,
  }) {
    return BasketState(
      errorStatus: errorStatus ?? this.errorStatus,
      fromStatus: fromStatus ?? this.fromStatus,
      errorString: errorString ?? this.errorString,
      products: products ?? this.products,
    );
  }
}
