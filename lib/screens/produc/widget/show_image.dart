import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gavhar_app/data/models/product/product_model.dart';
import 'package:gavhar_app/utils/app_constans/app_constans.dart';
import 'package:gavhar_app/utils/size_app.dart';

class ShowImage extends StatelessWidget {
  const ShowImage({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.we),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: Hero(
            tag: productModel.docId,
            child: CachedNetworkImage(
              fit: BoxFit.cover,
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
        ),
      ),
    );
  }
}
