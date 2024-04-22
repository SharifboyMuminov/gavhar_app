import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gavhar_app/data/models/product/product_model.dart';
import 'package:gavhar_app/utils/app_constans/app_constans.dart';

class ProductViewModel extends ChangeNotifier {
  List<ProductModel> products = [];

  bool _loading = false;

  bool get loading => _loading;

  _notifyListeners(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> callProducts() async {
    debugPrint("asdfadsf");
    _notifyListeners(true);

    try {
      await FirebaseFirestore.instance
          .collection(AppConst.productTableName)
          .get()
          .then((value) {
        products =
            value.docs.map((e) => ProductModel.fromJson(e.data())).toList();
        // debugPrint("product --------${products}");
      });
      _notifyListeners(false);
    } on FirebaseException catch (_) {
      debugPrint("on FirebaseException catch (_)");
    } catch (_) {
      debugPrint("catch (_)");
    }
  }

  Future<void> insertProduct({required ProductModel productModel}) async {
    debugPrint("asdfadsf");
    _notifyListeners(true);

    try {
      final cf = await FirebaseFirestore.instance
          .collection(AppConst.productTableName)
          .add(productModel.toJson());
      await FirebaseFirestore.instance
          .collection(AppConst.productTableName)
          .doc(cf.id)
          .update({"doc_id": cf.id});
      callProducts();
    } on FirebaseException catch (_) {
      debugPrint("Error insertProduct on FirebaseException catch (_)");
    } catch (_) {
      debugPrint("Error insertProduct catch (_)");
    }
  }
}
