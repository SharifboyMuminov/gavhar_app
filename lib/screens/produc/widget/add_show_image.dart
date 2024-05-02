import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gavhar_app/utils/app_constans/app_constans.dart';
import 'package:gavhar_app/utils/size_app.dart';

class ShowImageForAdd extends StatelessWidget {
  const ShowImageForAdd({
    super.key,
    required this.imageProvider,
    required this.onTab,
    required this.showSetImage,
  });

  final ImageProvider<Object> imageProvider;
  final VoidCallback onTab;
  final bool showSetImage;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 250.he,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 40,
              spreadRadius: 5,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
          onPressed: onTab,
          child: showSetImage
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 50.he,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: Colors.white24,
                      ),
                      child: Text(
                        "Set Image",
                        style: TextStyle(
                          color: Colors.amber,
                          fontWeight: FontWeight.w600,
                          fontSize: 18.sp,
                        ),
                      ),
                    ),
                  ],
                )
              : SizedBox(),
        ),
      ),
    );
  }
}
