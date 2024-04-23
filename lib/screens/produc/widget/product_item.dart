import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gavhar_app/data/models/product/product_model.dart';
import 'package:gavhar_app/utils/app_colors.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.productModel,
    required this.onTab,
    required this.onLongPress,
  });

  final ProductModel productModel;
  final VoidCallback onTab;
  final VoidCallback onLongPress;

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
        image: DecorationImage(
          image: NetworkImage(productModel.imageUrl),
        ),
      ),
      child: TextButton(
        style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        )),
        onPressed: onTab,
        onLongPress: onLongPress,
        child: const SizedBox(),
      ),
    );
  }
}
