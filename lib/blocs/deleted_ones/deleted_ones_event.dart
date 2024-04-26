import 'package:gavhar_app/data/models/product/product_model.dart';

abstract class DeletedOnesEvent {}

class DeletedOnesCallEvent extends DeletedOnesEvent {}

class DeletedOnesDeleteEvent extends DeletedOnesEvent {
  ProductModel productModel;

  DeletedOnesDeleteEvent({required this.productModel});
}

class DeletedOnesDeleteListEvent extends DeletedOnesEvent {
  List<ProductModel> productModels;
  bool delete_image;

  DeletedOnesDeleteListEvent(
      {required this.productModels, this.delete_image = true});
}

class DeletedOnesInsertEvent extends DeletedOnesEvent {
  ProductModel productModel;

  DeletedOnesInsertEvent({required this.productModel});
}
