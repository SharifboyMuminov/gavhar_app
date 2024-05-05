import 'package:gavhar_app/data/enums/status_enum.dart';
import 'package:gavhar_app/data/models/product/product_model.dart';

class LikeProductState {
  final List<ProductModel> likeProducts;
  final String errorMessage;
  final FromStatus status;
  final String statusMessage;

  LikeProductState({
    required this.statusMessage,
    required this.errorMessage,
    required this.likeProducts,
    required this.status,
  });

  LikeProductState copyWith({
    List<ProductModel>? likeProducts,
    String? errorMessage,
    FromStatus? status,
    String? statusMessage,
  }) {
    return LikeProductState(
      errorMessage: errorMessage ?? this.errorMessage,
      likeProducts: likeProducts ?? this.likeProducts,
      status: status ?? this.status,
      statusMessage: statusMessage ?? this.statusMessage,
    );
  }
}
