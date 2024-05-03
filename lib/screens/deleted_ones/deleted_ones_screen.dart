import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gavhar_app/blocs/deleted_ones/delete_ones_bloc.dart';
import 'package:gavhar_app/blocs/deleted_ones/deleted_ones_event.dart';
import 'package:gavhar_app/blocs/deleted_ones/deleted_ones_state.dart';
import 'package:gavhar_app/blocs/product/product_bloc.dart';
import 'package:gavhar_app/blocs/product/product_event.dart';
import 'package:gavhar_app/data/models/product/product_model.dart';
import 'package:gavhar_app/screens/widgets/product_item.dart';
import 'package:gavhar_app/utils/app_constans/app_constans.dart';
import 'package:gavhar_app/utils/size_app.dart';

class DeletedOnesScreen extends StatefulWidget {
  const DeletedOnesScreen({super.key});

  @override
  State<DeletedOnesScreen> createState() => _DeletedOnesScreenState();
}

class _DeletedOnesScreenState extends State<DeletedOnesScreen> {
  List<ProductModel> clickProducts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "Questions Screen",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          if (clickProducts.isNotEmpty)
            IconButton(
              onPressed: _insertProducts,
              icon: Icon(
                Icons.replay,
                color: Colors.black,
                size: 25.sp,
              ),
            ),
          if (clickProducts.isNotEmpty)
            IconButton(
              onPressed: _deleteProduct,
              icon: Icon(
                Icons.delete,
                color: Colors.redAccent,
                size: 25.sp,
              ),
            ),
        ],
      ),
      body: BlocBuilder<DeletedOnesBloc, DeletedOnesState>(
        builder: (BuildContext context, DeletedOnesState state) {
          if (state is ErrorDeletedOnesState) {
            if (state.errorText == "catch (_)") {
              return Image.asset(AppConst.errorImage);
            }
            return Center(child: Text(state.errorText));
          }
          if (state is ShowSnackBarDeletedOnesState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: state.color,
                content: Text(
                  state.text,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                  ),
                ),
              ),
            );
          }

          if (state is SuccessDeletedOnesState) {
            if (state.products.isEmpty) {
              return Center(
                  child: Image.asset(
                AppConst.emptyData,
                fit: BoxFit.cover,
              ));
            }

            return Stack(
              children: [
                // const BackGroundItem(),
                GridView.builder(
                  padding: EdgeInsets.only(
                      top: 20.he, left: 18.we, right: 18.we, bottom: 100.he),
                  itemCount: state.products.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20.he,
                    crossAxisSpacing: 15.we,
                    childAspectRatio: 0.75,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return ProductItem(
                      productModel: state.products[index],
                      onLongPress: () {
                        if (clickProducts.contains(state.products[index])) {
                          clickProducts.remove(state.products[index]);
                        } else {
                          clickProducts.add(state.products[index]);
                        }
                        setState(() {});
                      },
                      chek: clickProducts.contains(state.products[index]),
                      onTab: () {
                        if (clickProducts.isNotEmpty) {
                          if (clickProducts.contains(state.products[index])) {
                            clickProducts.remove(state.products[index]);
                          } else {
                            clickProducts.add(state.products[index]);
                          }
                          setState(() {});
                        }
                      },
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

  _deleteProduct({bool delete_image = true}) {
    context.read<DeletedOnesBloc>().add(DeletedOnesDeleteListEvent(
        productModels: clickProducts, delete_image: delete_image));
    _releaseProduct();
  }

  _releaseProduct() {
    clickProducts = [];
    setState(() {});
  }

  _insertProducts() {
    _deleteProduct(delete_image: false);
    if (clickProducts.length == 1) {
      context
          .read<ProductBloc>()
          .add(ProductInsertEvent(productModel: clickProducts[0]));
    } else {
      context
          .read<ProductBloc>()
          .add(ProductInsertForListEvent(productModels: clickProducts));
    }
    _releaseProduct();
  }
}
