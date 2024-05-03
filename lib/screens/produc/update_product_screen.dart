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
import 'package:gavhar_app/screens/produc/widget/add_show_image.dart';
import 'package:gavhar_app/screens/widgets/dialog/image_dialog.dart';
import 'package:gavhar_app/screens/widgets/my_input_widget.dart';
import 'package:gavhar_app/utils/platforma.dart';
import 'package:gavhar_app/utils/size_app.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProductScreen extends StatefulWidget {
  const UpdateProductScreen({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  String textGender = "Universal";
  List<String> listGender = ["Men", "Women", "Universal"];
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerPrice = TextEditingController();
  TextEditingController controllerDescription = TextEditingController();
  CategoryModel? currentCategoryModel;

  File? imageFileOne;
  XFile? xFileOne;
  File? imageFileTwo;
  XFile? xFileTwo;

  @override
  void initState() {
    // debugPrint("Makkami");
    controllerDescription.text = widget.productModel.description;
    controllerPrice.text = widget.productModel.price.toString();
    controllerName.text = widget.productModel.nameProduct;
    textGender = widget.productModel.gender;
    var a = globalCategories
        .where((element) => element.docId == widget.productModel.categoryId)
        .toList();
    currentCategoryModel = a.last;
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
                  SizedBox(width: width, height: 30.he),
                  Row(
                    children: [
                      ShowImageForAdd(
                          imageProvider: xFileOne == null
                              ? NetworkImage(
                                  widget.productModel.imageUrls.first)
                              : FileImage(imageFileOne!)
                                  as ImageProvider<Object>,
                          onTab: () {
                            showImageDialog(
                              context,
                              onChaneXFile: (ChangeImage changeImage) {
                                xFileOne = changeImage.xFile;
                                imageFileOne = File(changeImage.xFile!.path);
                                setState(() {});
                              },
                            );
                          },
                          showSetImage: true),
                      SizedBox(width: 10.we),
                      ShowImageForAdd(
                          isRight: false,
                          imageProvider: xFileTwo == null
                              ? NetworkImage(widget.productModel.imageUrls.last)
                              : FileImage(imageFileTwo!)
                                  as ImageProvider<Object>,
                          onTab: () {
                            showImageDialog(
                              context,
                              onChaneXFile: (ChangeImage changeImage) {
                                xFileTwo = changeImage.xFile;
                                imageFileTwo = File(changeImage.xFile!.path);
                                setState(() {});
                              },
                            );
                          },
                          showSetImage: true),
                    ],
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
                ],
              ),
            ),
    );
  }

  _saveProductOrUpdate() async {
    if (_testInout()) {
      _updateImages();
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

  Future<void> _updateImages() async {
    List<String> imagePaths = widget.productModel.storagePaths;
    List<String> imageUrls = widget.productModel.imageUrls;

    if (xFileOne != null) {
      String urlImageOne = "";
      context
          .read<ImageCubit>()
          .deleteImage(path: widget.productModel.storagePaths.first);
      urlImageOne = await context.read<ImageCubit>().addImageInFireBase(
          file: imageFileOne!, fileName: "product_image/${xFileOne!.name}");
      imagePaths.remove(widget.productModel.storagePaths.first);
      imageUrls.remove(widget.productModel.imageUrls.first);

      imagePaths.insert(0, "product_image/${xFileOne!.name}");
      imageUrls.insert(0, urlImageOne);
    }

    if (xFileTwo != null) {
      String urlImageTwo = "";

      context
          .read<ImageCubit>()
          .deleteImage(path: widget.productModel.storagePaths.last);
      urlImageTwo = await context.read<ImageCubit>().addImageInFireBase(
          file: imageFileTwo!, fileName: "product_image/${xFileTwo!.name}");
      imagePaths.remove(widget.productModel.storagePaths.last);
      imageUrls.remove(widget.productModel.imageUrls.last);

      imagePaths.add("product_image/${xFileTwo!.name}");
      imageUrls.add(urlImageTwo);
    }

    if (!context.mounted) return;
    context.read<ProductBloc>().add(
          ProductUpdateEvent(
            productModel: widget.productModel.copyWith(
              price: num.parse(controllerPrice.text),
              categoryId: currentCategoryModel!.docId,
              nameProduct: controllerName.text,
              description: controllerDescription.text,
              gender: textGender,
              storagePaths: imagePaths,
              imageUrls: imageUrls,
            ),
          ),
        );
    Navigator.pop(context);
    Navigator.pop(context);
  }

  bool _testInout() {
    return _testTExtInput() && currentCategoryModel != null;
  }

  bool _testTExtInput() {
    return controllerName.text.isNotEmpty &&
        controllerDescription.text.isNotEmpty &&
        controllerPrice.text.isNotEmpty;
  }

  @override
  void deactivate() {
    controllerName.dispose();
    controllerDescription.dispose();
    controllerPrice.dispose();
    super.deactivate();
  }
}
