import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gavhar_app/blocs/category/category_bloc.dart';
import 'package:gavhar_app/blocs/category/category_event.dart';
import 'package:gavhar_app/cubits/image/image_cubit.dart';
import 'package:gavhar_app/data/models/category/category_model.dart';
import 'package:gavhar_app/screens/widgets/dialog/ask_dialog.dart';
import 'package:gavhar_app/screens/widgets/dialog/image_dialog.dart';
import 'package:gavhar_app/screens/widgets/my_input_widget.dart';
import 'package:gavhar_app/utils/app_constans/app_constans.dart';
import 'package:gavhar_app/utils/platforma.dart';
import 'package:gavhar_app/utils/size_app.dart';
import 'package:image_picker/image_picker.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({super.key, this.categoryModel});

  final CategoryModel? categoryModel;

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  File? imageFile;
  XFile? xFile;
  TextEditingController textEditingController = TextEditingController();
  bool isEdit = false;

  @override
  void initState() {
    if (widget.categoryModel != null) {
      isEdit = true;

      textEditingController.text = widget.categoryModel!.categoryName;
    }
    // debugPrint(isEdit.toString());
    super.initState();
  }

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
            size: 25.sp,
          ),
        ),
        actions: [
          if (isEdit)
            IconButton(
              onPressed: () {
                showAskDialog(context, onTabOk: () {
                  context
                      .read<ImageCubit>()
                      .deleteImage(path: widget.categoryModel!.storagePath);
                  context.read<CategoryBloc>().add(CategoryDeleteEvent(
                      categoryModel: widget.categoryModel!));
                  Navigator.pop(context);
                  Navigator.pop(context);
                });
              },
              icon: Icon(
                Icons.delete,
                color: Colors.redAccent,
                size: 25.sp,
              ),
            ),
          IconButton(
            onPressed: chekk,
            icon: Icon(
              Icons.check,
              size: 25.sp,
            ),
          ),
          SizedBox(width: 10.we),
        ],
      ),
      body: context.watch<ImageCubit>().state
          ? const Center(child: CircularProgressIndicator.adaptive())
          : SingleChildScrollView(
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
                        image: isEdit && xFile == null
                            ? NetworkImage(widget.categoryModel!.imageUrl)
                            : xFile == null
                                ? const AssetImage(AppConst.inputImage)
                                : FileImage(imageFile!)
                                    as ImageProvider<Object>,
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

  Future<void> chekk() async {
    if (xFile != null) {
      CategoryModel categoryModel = CategoryModel.defaultModel();
      if (isEdit) {
        context
            .read<ImageCubit>()
            .deleteImage(path: widget.categoryModel!.storagePath);
      }
      String urlImage = await context.read<ImageCubit>().addImageInFireBase(
            file: imageFile!,
            fileName: "files/${xFile!.name}",
          );
      if (isEdit && context.mounted) {
        context.read<CategoryBloc>().add(
              CategoryUpdateEvent(
                categoryModel: widget.categoryModel!.copyWith(
                  imageUrl: urlImage,
                  categoryName: textEditingController.text,
                  storagePath: "files/${xFile!.name}",
                ),
              ),
            );
      } else {
        CategoryModel categoryModel = CategoryModel(
          storagePath: "files/${xFile!.name}",
          countProduct: 0,
          categoryName: textEditingController.text,
          docId: "",
          imageUrl: urlImage,
        );
        if (!context.mounted) return;
        context
            .read<CategoryBloc>()
            .add(CategoryInsertEvent(categoryModel: categoryModel));
      }
      if (!context.mounted) return;
    } else {
      if (isEdit) {
        context.read<CategoryBloc>().add(
              CategoryUpdateEvent(
                categoryModel: widget.categoryModel!.copyWith(
                  categoryName: textEditingController.text,
                ),
              ),
            );
      }
    }
    Navigator.pop(context);
  }
}
