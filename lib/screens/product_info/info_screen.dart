import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gavhar_app/blocs/basket/basket_bloc.dart';
import 'package:gavhar_app/blocs/basket/basket_event.dart';
import 'package:gavhar_app/blocs/like_product/like_product_bloc.dart';
import 'package:gavhar_app/blocs/like_product/like_product_event.dart';
import 'package:gavhar_app/data/enums/status_enum.dart';
import 'package:gavhar_app/data/models/product/product_model.dart';
import 'package:gavhar_app/screens/functions/functiosn.dart';
import 'package:gavhar_app/screens/produc/widget/show_image.dart';
import 'package:gavhar_app/utils/app_colors.dart';
import 'package:gavhar_app/utils/platforma.dart';
import 'package:gavhar_app/utils/size_app.dart';
import 'package:url_launcher/url_launcher.dart';

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
  int activeImage = 0;

  @override
  void initState() {
    productModel = widget.productModel;
    Future.microtask(
      () {
        productModel = productModel.copyWith(
            like: isThereProductInLike(
                productModels:
                    context.read<LikeProductBloc>().state.likeProducts,
                isThereProduct: productModel));
        // debugPrint("Like: ${productModel.like}");
        setState(() {});
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.c_FFFFFF,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 70.he),
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  backgroundColor: AppColors.c_FFFFFF,
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Platforma.ios
                          ? Icons.arrow_back_ios_new
                          : Icons.arrow_back,
                      size: 25.sp,
                    ),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {
                        if (productModel.like) {
                          // debugPrint("Delete Like Product---------");

                          context.read<LikeProductBloc>().add(
                              LikeProductDeleteEvent(
                                  productModel: productModel));
                        } else {
                          // debugPrint("Insert Like Product---------");
                          context.read<LikeProductBloc>().add(
                              LikeProductInsertEvent(
                                  productModel: productModel));
                        }
                        productModel =
                            productModel.copyWith(like: !productModel.like);
                        setState(() {});
                      },
                      icon: Icon(
                        productModel.like
                            ? Icons.favorite
                            : Icons.favorite_border,
                        size: 24.sp,
                        color: Colors.red,
                      ),
                    ),
                    SizedBox(width: 10.we),
                  ],
                  expandedHeight: 400.he,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Column(
                      children: [
                        SizedBox(height: 100.he),
                        Expanded(
                          child: Stack(
                            children: [
                              PageView(
                                onPageChanged: (v) {
                                  activeImage = v;
                                  setState(() {});
                                },
                                children: [
                                  Hero(
                                      tag: productModel.docId,
                                      child: ShowImage(
                                          productModel: productModel)),
                                  ShowImage(
                                      productModel: productModel,
                                      isChangeImage: true),
                                ],
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ...List.generate(
                                      productModel.imageUrls.length,
                                      (index) {
                                        return Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 15.he,
                                              horizontal: 5.we),
                                          height: 10.we,
                                          width: 10.we,
                                          decoration: BoxDecoration(
                                            color: activeImage == index
                                                ? Colors.white
                                                : Colors.white38,
                                            shape: BoxShape.circle,
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverList.list(
                  children: [
                    Container(
                      color: AppColors.c_FFFFFF,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.we, vertical: 20.he),
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
                            SizedBox(height: 30.he),
                            TextButton(
                              onPressed: () async {
                                var url = Uri.parse("https://t.me/ego_uz");
                                if (await canLaunchUrl(url)) {
                                  await launchUrl(url);
                                }
                              },
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    "assets/icons/telegram.svg",
                                    width: 40.we,
                                  ),
                                  SizedBox(width: 30.we),
                                  Text(
                                    "Telegram link",
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
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
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.h),
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 13.he),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  backgroundColor: AppColors.c_31363F,
                ),
                onPressed: () {
                  if (context.read<BasketProductBloc>().state.fromStatus !=
                      FromStatus.loading) {
                    context.read<BasketProductBloc>().add(
                          AddProductToBasketEvent(productModel: productModel),
                        );
                  }
                },
                child: Text(
                  "Add to Basket",
                  style: TextStyle(
                    color: AppColors.c_FFFFFF,
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
