import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gavhar_app/data/models/category/category_model.dart';
import 'package:gavhar_app/data/models/network_respons/network_respons_model.dart';
import 'package:gavhar_app/utils/app_constans/app_constans.dart';

class FireBaseData {
  static FirebaseFirestore fireBaseData = FirebaseFirestore.instance;

  Future<NetworkResponse> getCategories() async {
    NetworkResponse networkResponse = NetworkResponse();

    try {
      await FirebaseFirestore.instance
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
}
