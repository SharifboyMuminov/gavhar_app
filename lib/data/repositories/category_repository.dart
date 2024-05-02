import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gavhar_app/data/models/category/category_model.dart';
import 'package:gavhar_app/data/models/network_respons/network_respons_model.dart';
import 'package:gavhar_app/utils/app_constans/app_constans.dart';

class CategoryRepository {
  static FirebaseFirestore fireBaseData = FirebaseFirestore.instance;

  //----------------TODO Base Category----------
  Future<NetworkResponse> getCategories() async {
    NetworkResponse networkResponse = NetworkResponse();

    try {
      await fireBaseData
          .collection(AppConst.categoryTableName)
          .get()
          .then((value) {
        networkResponse.data =
            value.docs.map((e) => CategoryModel.fromJson(e.data())).toList();
        // debugPrint("product --------${products}");
      });
    } on FirebaseException catch (_) {
      networkResponse.errorText = "on FirebaseException catch (_)";
    } catch (_) {
      networkResponse.errorText = "catch (_)";
    }

    return networkResponse;
  }

  Future<NetworkResponse> insertCategory(CategoryModel categoryModel) async {
    NetworkResponse networkResponse = NetworkResponse();

    try {
      final cf = await fireBaseData
          .collection(AppConst.categoryTableName)
          .add(categoryModel.toJson());
      await fireBaseData
          .collection(AppConst.categoryTableName)
          .doc(cf.id)
          .update({"doc_id": cf.id});
    } on FirebaseException catch (_) {
      networkResponse.errorText = "on FirebaseException catch (_)";
    } catch (_) {
      networkResponse.errorText = "catch (_)";
    }

    return networkResponse;
  }

  Future<NetworkResponse> updateCategory(CategoryModel categoryModel) async {
    NetworkResponse networkResponse = NetworkResponse();

    try {
      await fireBaseData
          .collection(AppConst.categoryTableName)
          .doc(categoryModel.docId)
          .update(categoryModel.toJson());
    } on FirebaseException catch (_) {
      networkResponse.errorText = "on FirebaseException catch (_)";
    } catch (_) {
      networkResponse.errorText = "catch (_)";
    }

    return networkResponse;
  }

  Future<NetworkResponse> deleteCategory(CategoryModel categoryModel) async {
    NetworkResponse networkResponse = NetworkResponse();

    try {
      await fireBaseData
          .collection(AppConst.categoryTableName)
          .doc(categoryModel.docId)
          .delete();
    } on FirebaseException catch (_) {
      networkResponse.errorText = "on FirebaseException catch (_)";
    } catch (_) {
      networkResponse.errorText = "catch (_)";
    }

    return networkResponse;
  }
}
