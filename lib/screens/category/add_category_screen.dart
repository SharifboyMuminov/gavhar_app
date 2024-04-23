import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gavhar_app/screens/widgets/dialog/image_dialog.dart';
import 'package:gavhar_app/screens/widgets/my_input_widget.dart';
import 'package:gavhar_app/utils/app_constans/app_constans.dart';
import 'package:gavhar_app/utils/platforma.dart';
import 'package:gavhar_app/utils/size_app.dart';
import 'package:image_picker/image_picker.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({super.key});

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  File? imageFile;
  XFile? xFile;
  TextEditingController textEditingController = TextEditingController();
  Uint8List? uint8list;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: Platforma.android,
        title: Text(
          "Add Category",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 20.sp,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            defaultTargetPlatform == TargetPlatform.iOS
                ? Icons.arrow_back_ios_new
                : Icons.arrow_back,
            size: 24.sp,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.check,
              size: 28.sp,
            ),
          ),
          SizedBox(width: 10.we),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.we),
        child: Column(
          children: [
            SizedBox(width: width, height: 40.he),
            Container(
              width: width - 100,
              height: width - 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                image: DecorationImage(
                  image: xFile == null
                      ? const AssetImage(AppConst.inputImage)
                      : FileImage(imageFile!) as ImageProvider<Object>,
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
                onPressed: () {
                  showImageDialog(
                    context,
                    onChaneXFile: (ChangeImage changeImage) {
                      if (changeImage.xFile != null) {
                        xFile = changeImage.xFile;
                        imageFile = File(xFile!.path);
                      }
                      setState(() {});
                    },
                  );
                },
                child: xFile == null
                    ? const SizedBox()
                    : Column(
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
                      ),
              ),
            ),
            SizedBox(height: 20.he),
            TextInputMyWidget(
              textInputAction: TextInputAction.done,
              label: 'Enter category name',
              textEditingController: textEditingController,
              isError: false,
            ),
          ],
        ),
      ),
    );
  }
}
