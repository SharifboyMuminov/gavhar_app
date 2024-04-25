import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gavhar_app/data/models/product/product_model.dart';
import 'package:gavhar_app/utils/app_colors.dart';
import 'package:gavhar_app/utils/app_constans/app_constans.dart';
import 'package:gavhar_app/utils/size_app.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.productModel,
    required this.onTab,
    required this.onLongPress,
    this.chek = false,
  });

  final ProductModel productModel;
  final VoidCallback onTab;
  final VoidCallback onLongPress;
  final bool chek;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: AppColors.c_FFFFFF,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 30,
            spreadRadius: 1,
            offset: const Offset(0, 17),
          ),
        ],
      ),
      child: Stack(
        children: [
          TextButton(
            style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            )),
            onPressed: onTab,
            onLongPress: onLongPress,
            child: Column(
              children: [
                Hero(
                  tag: productModel.docId,
                  child: CachedNetworkImage(
                    imageUrl: productModel.imageUrl,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator.adaptive(),
                    errorWidget: (context, url, error) {
                      debugPrint("errorWidget asdfasd asdf asdafd");
                      return Image.asset(
                        AppConst.notImage,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          if (chek)
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  backgroundColor: Colors.orange.withOpacity(0.4),
                ),
                onLongPress: onLongPress,
                onPressed: null,
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 50.we,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
