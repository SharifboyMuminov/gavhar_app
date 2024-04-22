import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gavhar_app/data/models/product/product_model.dart';
import 'package:gavhar_app/utils/app_colors.dart';
import 'package:gavhar_app/utils/platforma.dart';
import 'package:gavhar_app/utils/size_app.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen(
      {super.key, required this.productModel, this.isRequest = false});

  final ProductModel productModel;
  final bool isRequest;

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  late ProductModel productModel;

  @override
  void initState() {
    productModel = widget.productModel;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.c_FFFFFF,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: AppColors.c_FFFFFF,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Platforma.ios ? Icons.arrow_back_ios_new : Icons.arrow_back,
                size: 25.sp,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) {
                  //       return AddAndUpdateScreen(
                  //         context: context,
                  //         productModel: productModel,
                  //         request: widget.isRequest,
                  //       );
                  //     },
                  //   ),
                  // );
                },
                icon: Icon(
                  Icons.edit,
                  size: 25.sp,
                ),
              ),
              // if (widget.isRequest)
              //   IconButton(
              //     onPressed: () {
              //       // context.read<ProductViewModel>().insertProducts(
              //       //     context,
              //       //     productModel: productModel);
              //       // globalAnimationController.forward();
              //     },
              //     icon: Icon(
              //     ,
              //     size: 24.sp,
              //     ),
              //   ),
              //   IconButton(
              //     onPressed: () {},
              //     icon: Icon(
              //       Platforma.android ? Icons.arrow_back_ios_new : Icons
              //           .arrow_back,
              //     ),
              //   ),
            ],
            expandedHeight: 400.he,
            flexibleSpace: FlexibleSpaceBar(
              background: Column(
                children: [
                  SizedBox(height: 50.he),
                  Expanded(
                    child: Image.asset(
                      productModel.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList.list(
            children: [
              // GridView.extent(maxCrossAxisExtent: maxCrossAxisExtent),
              Container(
                color: AppColors.c_FFFFFF,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.we, vertical: 20.he),
                  decoration: BoxDecoration(
                    // color: Colors.red,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.r),
                      topRight: Radius.circular(15.r),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productModel.nameProduct,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                          fontSize: 22.sp,
                        ),
                      ),
                      SizedBox(height: 10.he),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            productModel.gender != "Universal"
                                ? "For ${productModel.gender}"
                                : productModel.gender,
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w400,
                              fontSize: 22.sp,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.he),
                      Text(
                        "${productModel.price} sum",
                        maxLines: 2,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                          fontSize: 22.sp,
                        ),
                      ),
                      SizedBox(height: 20.he),
                      Text(
                        "Description:",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                          fontSize: 22.sp,
                        ),
                      ),
                      SizedBox(height: 10.he),
                      Text(
                        productModel.description,
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
