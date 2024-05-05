import 'package:gavhar_app/data/models/product/product_model.dart';

bool isThereProductInLike(
    {required List<ProductModel> productModels,
    required ProductModel isThereProduct}) {
  // debugPrint("--------length: ${productModels}");

  for (ProductModel productModel in productModels) {
    if (productModel.docId == isThereProduct.docId) {
      // debugPrint("Topildi :)");
      return true;
    }
  }
  // debugPrint("Topildimadi :(");

  return false;
}
