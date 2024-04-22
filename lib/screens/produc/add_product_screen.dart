import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gavhar_app/data/models/category/category_model.dart';
import 'package:gavhar_app/screens/widgets/dialog/image_dialog.dart';
import 'package:gavhar_app/screens/widgets/my_input_widget.dart';
import 'package:gavhar_app/utils/app_constans/app_constans.dart';
import 'package:gavhar_app/utils/platforma.dart';
import 'package:gavhar_app/utils/size_app.dart';
import 'package:image_picker/image_picker.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  List<CategoryModel> categories = [
    CategoryModel(
        storagePath: "",
        countProduct: 0,
        categoryName: "Sharifjo",
        docId: "",
        imageUrl: ""),
    CategoryModel(
        storagePath: "",
        countProduct: 0,
        categoryName: "Qonday",
        docId: "",
        imageUrl: ""),
  ];
  String textGender = "Universal";
  List<String> listGender = ["Men", "Women", "Universal"];
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
          "Add Product",
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
        padding: EdgeInsets.only(left: 20.we, right: 20.we, bottom: 30.he),
        child: Column(
          children: [
            SizedBox(width: width, height: 40.he),
            Container(
              width: width - 100,
              height: width - 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                image: DecorationImage(
                  image: AssetImage(
                      xFile == null ? AppConst.inputImage : xFile!.path),
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
                      xFile = changeImage.xFile;
                      imageFile = File(changeImage.xFile!.path);
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
            SizedBox(height: 15.he),
            TextInputMyWidget(
              label: 'Enter product name',
              textEditingController: textEditingController,
              isError: false,
            ),
            TextInputMyWidget(
              textInputType: TextInputType.number,
              label: 'Enter price',
              textEditingController: textEditingController,
              isError: false,
            ),
            TextInputMyWidget(
              textInputType: TextInputType.number,
              textInputAction: TextInputAction.done,
              label: 'Enter description',
              textEditingController: textEditingController,
              isError: false,
            ),
            SizedBox(height: 20.he),
            DropdownMenu<CategoryModel>(
              selectedTrailingIcon: Icon(
                Icons.category,
                size: 18.sp,
                color: Colors.black,
              ),
              label: Text(
                "Category",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              width: width - 50,
              // initialSelection: /,
              onSelected: (CategoryModel? value) {
                // This is called when the user selects an item.
                setState(
                  () {},
                );
              },

              dropdownMenuEntries: categories.map(
                (CategoryModel value) {
                  return DropdownMenuEntry<CategoryModel>(
                      value: value, label: value.categoryName);
                },
              ).toList(),
            ),
            SizedBox(height: 20.he),
            DropdownMenu<String>(
              selectedTrailingIcon: Icon(
                Icons.check,
                size: 18.sp,
                color: Colors.black,
              ),
              label: Text(
                "Gender",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              width: width - 50,
              initialSelection: textGender,
              onSelected: (String? value) {
                // This is called when the user selects an item.
                setState(
                  () {
                    textGender = value!;
                  },
                );
              },
              dropdownMenuEntries: listGender.map<DropdownMenuEntry<String>>(
                (String value) {
                  return DropdownMenuEntry<String>(value: value, label: value);
                },
              ).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
