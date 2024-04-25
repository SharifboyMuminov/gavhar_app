import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gavhar_app/blocs/product/product_bloc.dart';
import 'package:gavhar_app/blocs/product/product_event.dart';
import 'package:gavhar_app/cubits/image/image_cubit.dart';
import 'package:gavhar_app/data/local/local_varibals.dart';
import 'package:gavhar_app/data/models/category/category_model.dart';
import 'package:gavhar_app/data/models/product/product_model.dart';
import 'package:gavhar_app/screens/widgets/dialog/image_dialog.dart';
import 'package:gavhar_app/screens/widgets/my_input_widget.dart';
import 'package:gavhar_app/utils/app_constans/app_constans.dart';
import 'package:gavhar_app/utils/platforma.dart';
import 'package:gavhar_app/utils/size_app.dart';
import 'package:image_picker/image_picker.dart';

class AddAndUpdateScreen extends StatefulWidget {
  const AddAndUpdateScreen({super.key, this.productModel});

  final ProductModel? productModel;

  @override
  State<AddAndUpdateScreen> createState() => _AddAndUpdateScreenState();
}

class _AddAndUpdateScreenState extends State<AddAndUpdateScreen> {
  String textGender = "Universal";
  List<String> listGender = ["Men", "Women", "Universal"];
  File? imageFile;
  XFile? xFile;
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerPrice = TextEditingController();
  TextEditingController controllerDescription = TextEditingController();
  CategoryModel? currentCategoryModel;

  bool isEdit = false;

  @override
  void initState() {
    if (widget.productModel != null) {
      // debugPrint("Makkami");
      isEdit = true;
      controllerDescription.text = widget.productModel!.description;
      controllerPrice.text = widget.productModel!.price.toString();
      controllerName.text = widget.productModel!.nameProduct;
      textGender = widget.productModel!.gender;
      var a = globalCategories
          .where((element) => element.docId == widget.productModel!.categoryId)
          .toList();
      currentCategoryModel = a.last;
    }
    super.initState();
  }

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
            onPressed: _saveProductOrUpdate,
            icon: Icon(
              Icons.check,
              size: 28.sp,
            ),
          ),
          SizedBox(width: 10.we),
        ],
      ),
      body: context.watch<ImageCubit>().state
          ? const Center(child: CircularProgressIndicator.adaptive())
          : SingleChildScrollView(
              padding:
                  EdgeInsets.only(left: 20.we, right: 20.we, bottom: 50.he),
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
                            ? NetworkImage(widget.productModel!.imageUrl)
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
                            xFile = changeImage.xFile;
                            imageFile = File(changeImage.xFile!.path);
                            setState(() {});
                          },
                        );
                      },
                      child: xFile == null || (!isEdit)
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
                    textEditingController: controllerName,
                    isError: false,
                  ),
                  TextInputMyWidget(
                    textInputType: TextInputType.number,
                    label: 'Enter price',
                    textEditingController: controllerPrice,
                    isError: false,
                  ),
                  TextInputMyWidget(
                    textInputType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    label: 'Enter description',
                    textEditingController: controllerDescription,
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
                    onSelected: (CategoryModel? categoryModel) {
                      // This is called when the user selects an item.
                      setState(
                        () {
                          currentCategoryModel = categoryModel;
                        },
                      );
                    },

                    dropdownMenuEntries: globalCategories.map(
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
                    dropdownMenuEntries:
                        listGender.map<DropdownMenuEntry<String>>(
                      (String value) {
                        return DropdownMenuEntry<String>(
                            value: value, label: value);
                      },
                    ).toList(),
                  ),
                ],
              ),
            ),
    );
  }

  _saveProductOrUpdate() async {
    if (_testInout()) {
      String urlImage = "";

      if (isEdit) {
        bool setImage = xFile != null;
        if (xFile != null) {
          context
              .read<ImageCubit>()
              .deleteImage(path: widget.productModel!.storagePath);
          urlImage = await context.read<ImageCubit>().addImageInFireBase(
              file: imageFile!, fileName: "product_image/${xFile!.name}");
        }
        if (!context.mounted) return;
        context.read<ProductBloc>().add(
              ProductUpdateEvent(
                productModel: widget.productModel!.copyWith(
                  price: num.parse(controllerPrice.text),
                  categoryId: currentCategoryModel!.docId,
                  nameProduct: controllerName.text,
                  description: controllerDescription.text,
                  gender: textGender,
                  storagePath: setImage
                      ? "product_image/${xFile!.name}"
                      : widget.productModel!.storagePath,
                  imageUrl: setImage ? urlImage : widget.productModel!.imageUrl,
                ),
              ),
            );
        Navigator.pop(context);
      } else {
        urlImage = await context.read<ImageCubit>().addImageInFireBase(
            file: imageFile!, fileName: "product_image/${xFile!.name}");

        context.read<ProductBloc>().add(
              ProductInsertEvent(
                productModel: ProductModel(
                  storagePath: "product_image/${xFile!.name}",
                  price: num.parse(controllerPrice.text),
                  categoryId: currentCategoryModel!.docId,
                  nameProduct: controllerName.text,
                  description: controllerDescription.text,
                  gender: textGender,
                  docId: "",
                  imageUrl: urlImage,
                ),
              ),
            );
      }
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 1),
          content: Text(
            "Empty input",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    }
  }

  bool _testInout() {
    if (isEdit) {
      return _testTExtInput() && currentCategoryModel != null;
    }
    return _testTExtInput() && currentCategoryModel != null && xFile != null;
  }

  bool _testTExtInput() {
    return controllerName.text.isNotEmpty &&
        controllerDescription.text.isNotEmpty &&
        controllerPrice.text.isNotEmpty;
  }
}
