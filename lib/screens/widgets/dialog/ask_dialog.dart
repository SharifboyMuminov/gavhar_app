import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

showAskDialog(BuildContext context, {required String title,required VoidCallback onTabOk}) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog.adaptive(
          title: Text(
            title,
            style: TextStyle(color: Colors.black, fontSize: 20.sp),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Cancel",
                style: TextStyle(fontSize: 16.sp),
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero),
              ),
              onPressed: onTabOk,
              child: Text(
                "Ok",
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.redAccent,
                ),
              ),
            ),
          ],
        );
      });
}
