import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gavhar_app/utils/size_app.dart';

class TextInputMyWidget extends StatelessWidget {
  TextInputMyWidget({
    super.key,
    required this.label,
    this.textInputType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    required this.textEditingController,
    required this.isError,
  });

  final String label;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final TextEditingController textEditingController;
  bool isError;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15.he),
      child: TextFormField(
        maxLines: null,
        cursorColor: Colors.amber,
        controller: textEditingController,
        keyboardType: textInputType,
        textInputAction: textInputAction,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 18.sp,
        ),
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 10.we, vertical: 15.he),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.amber, width: 2.we),
            borderRadius: BorderRadius.circular(10.r),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.we),
            borderRadius: BorderRadius.circular(10.r),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1.we),
            borderRadius: BorderRadius.circular(10.r),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2.we),
            borderRadius: BorderRadius.circular(10.r),
          ),
          label: Text(
            label,
            style: TextStyle(
              color: isError ? Colors.red : Colors.black54,
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          error: isError
              ? Text(
                  "Error...",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 17.sp,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
