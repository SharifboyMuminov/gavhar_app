import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gavhar_app/blocs/like_product/like_product_bloc.dart';
import 'package:gavhar_app/blocs/like_product/like_product_state.dart';
import 'package:gavhar_app/data/enums/status_enum.dart';
import 'package:gavhar_app/data/models/product/product_model.dart';
import 'package:gavhar_app/screens/product_info/info_screen.dart';
import 'package:gavhar_app/screens/widgets/product_item.dart';
import 'package:gavhar_app/utils/app_constans/app_constans.dart';
import 'package:gavhar_app/utils/platforma.dart';
import 'package:gavhar_app/utils/size_app.dart';

class LikeProductScreen extends StatefulWidget {
  const LikeProductScreen({super.key});

  @override
  State<LikeProductScreen> createState() => _LikeProductScreenState();
}

class _LikeProductScreenState extends State<LikeProductScreen> {
  List<ProductModel> clickProducts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: Platform.isAndroid,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Platforma.ios ? Icons.arrow_back_ios_new : Icons.arrow_back,
            size: 25.sp,
          ),
        ),
        title: Text(
          "Like Screen",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: BlocBuilder<LikeProductBloc, LikeProductState>(
        builder: (BuildContext context, LikeProductState state) {
          if (state.status == FromStatus.error) {
            if (state.errorMessage == "error") {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "Error :(",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 20.sp,
                    ),
                  ),
                ),
              );
            }
            return Center(child: Image.asset(AppConst.errorImage));
          }

          if (state.status == FromStatus.success) {
            if (state.likeProducts.isEmpty) {
              return Center(
                child: Image.asset(
                  AppConst.emptyData,
                  fit: BoxFit.cover,
                ),
              );
            }

            return GridView.builder(
              padding: EdgeInsets.only(
                  top: 20.he, left: 18.we, right: 18.we, bottom: 100.he),
              itemCount: state.likeProducts.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20.he,
                  crossAxisSpacing: 15.we,
                  childAspectRatio: 0.75
                  // mainAxisExtent: 1
                  ),
              itemBuilder: (BuildContext context, int index) {
                return ProductItem(
                  productModel: state.likeProducts[index],
                  onTab: () {
                    if (clickProducts.isNotEmpty) {
                      if (clickProducts.contains(state.likeProducts[index])) {
                        clickProducts.remove(state.likeProducts[index]);
                      } else {
                        clickProducts.add(state.likeProducts[index]);
                      }
                      setState(() {});
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return InfoScreen(
                                productModel: state.likeProducts[index]);
                          },
                        ),
                      );
                    }
                  },
                  onLongPress: () {
                    if (clickProducts.contains(state.likeProducts[index])) {
                      clickProducts.remove(state.likeProducts[index]);
                    } else {
                      clickProducts.add(state.likeProducts[index]);
                    }
                    setState(() {});
                  },
                );
              },
            );
          }

          return const Center(child: CircularProgressIndicator.adaptive());
        },
      ),
    );
  }
}
