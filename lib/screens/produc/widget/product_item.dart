import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gavhar_app/data/models/product/product_model.dart';
import 'package:gavhar_app/utils/app_colors.dart';
import 'package:gavhar_app/utils/size_app.dart';

class ProductItem extends StatelessWidget {
  const ProductItem(
      {super.key,
      required this.onLongPress,
      required this.index,
      required this.onTab,
      required this.productModel});

  final VoidCallback onLongPress;
  final int index;
  final VoidCallback onTab;
  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return Ink(
      height: index.isEven ? 200.he : 250.he,
      padding: EdgeInsets.only(bottom: 5.he),
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
      child: InkWell(
        onLongPress: onLongPress,
        onTap: onTab,
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: Image.asset(
                  productModel.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "  ${productModel.nameProduct}",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 18.sp,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.we),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "${productModel.price}som",
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
