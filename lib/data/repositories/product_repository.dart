import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gavhar_app/data/models/network_respons/network_respons_model.dart';
import 'package:gavhar_app/data/models/product/product_model.dart';
import 'package:gavhar_app/utils/app_constans/app_constans.dart';

class ProductRepository {
  static FirebaseFirestore fireBaseData = FirebaseFirestore.instance;

  //----------------TODO Base Product----------

  Future<NetworkResponse> getProducts() async {
    NetworkResponse networkResponse = NetworkResponse();

    try {
      await fireBaseData
          .collection(AppConst.productTableName)
          .get()
          .then((value) {
        // debugPrint(value.toString());
        try {
          networkResponse.data =
              value.docs.map((e) => ProductModel.fromJson(e.data())).toList();
        } catch (error) {
          // debugPrint("${error}----------");
        }
      });
    } on FirebaseException catch (_) {
      networkResponse.errorText = "on FirebaseException catch (_)";
    } catch (_) {
      networkResponse.errorText = "catch (_)";
    }

    return networkResponse;
  }

  Future<NetworkResponse> insertProducts(ProductModel productModel) async {
    NetworkResponse networkResponse = NetworkResponse();

    try {
      final cf = await fireBaseData
          .collection(AppConst.productTableName)
          .add(productModel.toJson());
      await fireBaseData
          .collection(AppConst.productTableName)
          .doc(cf.id)
          .update({"doc_id": cf.id});
    } on FirebaseException catch (_) {
      networkResponse.errorText = "on FirebaseException catch (_)";
    } catch (_) {
      networkResponse.errorText = "catch (_)";
    }

    return networkResponse;
  }

  Future<NetworkResponse> insertProductForList(
      List<ProductModel> productModels) async {
    NetworkResponse networkResponse = NetworkResponse();

    try {
      for (int i = 0; i < productModels.length; i++) {
        final cf = await FirebaseFirestore.instance
            .collection(AppConst.productTableName)
            .add(productModels[i].toJson());
        await FirebaseFirestore.instance
            .collection(AppConst.productTableName)
            .doc(cf.id)
            .update({"doc_id": cf.id});
      }
    } on FirebaseException catch (_) {
      networkResponse.errorText = "on FirebaseException catch (_)";
    } catch (_) {
      networkResponse.errorText = "catch (_)";
    }

    return networkResponse;
  }

  Future<NetworkResponse> updateProducts(ProductModel productModel) async {
    NetworkResponse networkResponse = NetworkResponse();

    try {
      await FirebaseFirestore.instance
          .collection(AppConst.productTableName)
          .doc(productModel.docId)
          .update(productModel.toJson());
    } on FirebaseException catch (_) {
      networkResponse.errorText = "on FirebaseException catch (_)";
    } catch (_) {
      networkResponse.errorText = "catch (_)";
    }

    return networkResponse;
  }

  Future<NetworkResponse> deleteProducts(ProductModel productModel) async {
    NetworkResponse networkResponse = NetworkResponse();

    try {
      await FirebaseFirestore.instance
          .collection(AppConst.productTableName)
          .doc(productModel.docId)
          .delete();
    } on FirebaseException catch (_) {
      networkResponse.errorText = "on FirebaseException catch (_)";
    } catch (_) {
      networkResponse.errorText = "catch (_)";
    }

    return networkResponse;
  }

  Future<NetworkResponse> getProductForId(String categoryId) async {
    NetworkResponse networkResponse = NetworkResponse();

    try {
      await FirebaseFirestore.instance
          .collection(AppConst.productTableName)
          .where("category_id", isEqualTo: categoryId)
          .get()
          .then((value) {
        // debugPrint(value.toString());
        try {
          networkResponse.data =
              value.docs.map((e) => ProductModel.fromJson(e.data())).toList();
        } catch (error) {
          // debugPrint("${error}----------");
        }
      });
    } on FirebaseException catch (_) {
      networkResponse.errorText = "on FirebaseException catch (_)";
    } catch (_) {
      networkResponse.errorText = "catch (_)";
    }

    return networkResponse;
  }
}
