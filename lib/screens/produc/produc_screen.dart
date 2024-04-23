import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gavhar_app/blocs/product/product_bloc.dart';
import 'package:gavhar_app/blocs/product/product_state.dart';
import 'package:gavhar_app/data/local/local_varibals.dart';
import 'package:gavhar_app/data/models/product/product_model.dart';
import 'package:gavhar_app/screens/produc/add_product_screen.dart';
import 'package:gavhar_app/screens/produc/info_screen.dart';
import 'package:gavhar_app/screens/widgets/backgeound_conteyner.dart';
import 'package:gavhar_app/screens/widgets/background_item.dart';
import 'package:gavhar_app/utils/app_colors.dart';
import 'package:gavhar_app/utils/size_app.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Product Screen",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              globalAnimationController.reverse();

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const AddProductScreen();
                  },
                ),
              ).then((value) {
                globalAnimationController.forward();
              });
            },
            icon: Icon(
              Icons.add,
              size: 25.sp,
              color: Colors.black,
            ),
          ),
          SizedBox(width: 10.we),
        ],
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (BuildContext context, ProductState state) {
          if (state is ErrorProductState) {
            return Center(child: Text(state.errorText));
          }

          if (state is SuccessProductState) {
            return Stack(
              children: [
                const BackGroundItem(),
                GridView.builder(
                  padding: EdgeInsets.only(
                      top: 20.he, left: 18.we, right: 18.we, bottom: 100.he),
                  itemCount: 20,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20.he,
                      crossAxisSpacing: 15.we,
                      childAspectRatio: 0.7
                      // mainAxisExtent: 1
                      ),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: AppColors.c_FFFFFF,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 30,
                            spreadRadius: 1,
                            offset: const Offset(0, 17),
                          ),
                        ],
                        image: DecorationImage(
                          image: AssetImage(globalProduct.imageUrl),
                        ),
                      ),
                      child: TextButton(
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        )),
                        onPressed: () {
                          globalAnimationController.reverse();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return InfoScreen(productModel: globalProduct);
                              },
                            ),
                          ).then((value) {
                            globalAnimationController.forward();
                          });
                        },
                        child: const SizedBox(),
                      ),
                    );
                  },
                ),
              ],
            );
          }

          return const Center(child: CircularProgressIndicator.adaptive());
        },
      ),
    );
  }
}

final ProductModel globalProduct = ProductModel(
  storagePath: "",
  description: "asdgfa sasdg asdga sdfa sdga sfgabds asfgbtrbadf sfgb",
  gender: "Women",
  nameProduct: "Zirak",
  categoryId: "",
  docId: "",
  imageUrl: "assets/images/rings.png",
  price: 50000000000,
);
