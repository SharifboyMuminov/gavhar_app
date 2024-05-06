import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/app_colors.dart';

class SetMyButton extends StatelessWidget {
  const SetMyButton({super.key, required this.onTab, required this.iconData});

  final VoidCallback onTab;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        side: BorderSide(color: AppColors.c_2C4E80, width: 2.w),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      ),
      onPressed: onTab,
      child: Icon(
        iconData,
        size: 24.sp,
        color: AppColors.c_2C4E80,
      ),
    );
  }
}
