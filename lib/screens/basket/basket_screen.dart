import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gavhar_app/blocs/basket/basket_bloc.dart';
import 'package:gavhar_app/blocs/basket/basket_event.dart';
import 'package:gavhar_app/blocs/basket/basket_state.dart';
import 'package:gavhar_app/data/enums/status_enum.dart';
import 'package:gavhar_app/screens/basket/widget/set_button.dart';
import 'package:gavhar_app/screens/basket/widget/show_image.dart';
import 'package:gavhar_app/utils/app_colors.dart';
import 'package:gavhar_app/utils/app_constans/app_constans.dart';
import 'package:gavhar_app/utils/size_app.dart';

import '../produc/widget/show_image.dart';

class BasketScreen extends StatefulWidget {
  const BasketScreen({super.key});

  @override
  State<BasketScreen> createState() => _BasketScreenState();
}

class _BasketScreenState extends State<BasketScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Basekt Screen",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: BlocConsumer<BasketProductBloc, BasketState>(
        builder: (BuildContext context, BasketState state) {
          if (state.fromStatus == FromStatus.error) {
            return Image.asset(AppConst.errorImage);
          }

          if (state.fromStatus == FromStatus.success) {
            if (state.products.isEmpty) {
              return Center(
                child: Image.asset(
                  AppConst.emptyData,
                  fit: BoxFit.cover,
                ),
              );
            }
            return ListView.builder(
              padding: EdgeInsets.only(
                  top: 20.he, left: 18.we, right: 18.we, bottom: 100.he),
              itemCount: state.products.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 10.he),
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.we, vertical: 10.he),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: AppColors.c_2C4E80, width: 2.we),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ShowOneImage(
                              urlImage: state.products[index].imageUrls.first),
                          ShowOneImage(
                              urlImage: state.products[index].imageUrls.last),
                        ],
                      ),
                      SizedBox(height: 10.he),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SetMyButton(
                              onTab: () {
                                context.read<BasketProductBloc>().add(
                                      UpdateProductBasketEvent(
                                          productModel: state.products[index]
                                              .copyWith(
                                                  count: state.products[index]
                                                          .count -
                                                      1),
                                          index: index,
                                          remove: true),
                                    );
                              },
                              iconData: Icons.remove),
                          Text(
                            state.products[index].count.toString(),
                            style: TextStyle(
                              color: AppColors.c_2C4E80,
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SetMyButton(
                              onTab: () {
                                context.read<BasketProductBloc>().add(
                                      UpdateProductBasketEvent(
                                          productModel: state.products[index]
                                              .copyWith(
                                                  count: state.products[index]
                                                          .count +
                                                      1),
                                          index: index),
                                    );
                              },
                              iconData: Icons.add),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          }

          return const Center(child: CircularProgressIndicator.adaptive());
        },
        listener: (BuildContext context, BasketState state) {
          if (state.errorStatus == "set_state") {
            setState(() {});
          }
        },
      ),
    );
  }
}
