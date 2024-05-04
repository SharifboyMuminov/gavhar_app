import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gavhar_app/blocs/product/product_bloc.dart';
import 'package:gavhar_app/blocs/product/product_state.dart';
import 'package:gavhar_app/data/local/local_varibals.dart';
import 'package:gavhar_app/screens/product_info/info_screen.dart';
import 'package:gavhar_app/screens/widgets/product_item.dart';
import 'package:gavhar_app/utils/app_constans/app_constans.dart';
import 'package:gavhar_app/utils/size_app.dart';

class ShowProductForCategoryId extends StatefulWidget {
  const ShowProductForCategoryId({super.key});

  @override
  State<ShowProductForCategoryId> createState() =>
      _ShowProductForCategoryIdState();
}

class _ShowProductForCategoryIdState extends State<ShowProductForCategoryId> {
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: Platform.isAndroid,
        title: Text(
          "Product Screen",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (BuildContext context, ProductState state) {
          if (state is ErrorProductState) {
            if (state.errorText == "catch (_)") {
              return Center(child: Text(state.errorText));
            }
            return Center(child: Text(state.errorText));
          }

          if (state is SuccessProductState) {
            if (state.products.isEmpty) {
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
              itemCount: state.products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20.he,
                  crossAxisSpacing: 15.we,
                  childAspectRatio: 0.75
                  // mainAxisExtent: 1
                  ),
              itemBuilder: (BuildContext context, int index) {
                return ProductItem(
                  productModel: state.products[index],
                  onTab: () {
                    globalAnimationController.reverse();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return InfoScreen(
                              productModel: state.products[index]);
                        },
                      ),
                    ).then((value) {
                      globalAnimationController.forward();
                    });
                  },
                  onLongPress: () {
                    // context.read<ProductBloc>().add(ProductDeleteEvent(
                    //     productModel: state.products[index]));
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
