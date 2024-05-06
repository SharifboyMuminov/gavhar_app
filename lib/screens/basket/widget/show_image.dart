import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gavhar_app/utils/size_app.dart';

import '../../../utils/app_constans/app_constans.dart';

class ShowOneImage extends StatelessWidget {
  const ShowOneImage({super.key, required this.urlImage});

  final String urlImage;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.r),
      child: CachedNetworkImage(
        imageUrl: urlImage,
        placeholder: (context, url) =>
            const Center(child: CircularProgressIndicator.adaptive()),
        errorWidget: (context, url, error) => Image.asset(AppConst.errorImage),
        width: 140.we,
        height: 140.we,
        fit: BoxFit.cover,
      ),
    );
  }
}
