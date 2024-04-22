import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gavhar_app/data/local/local_varibals.dart';
import 'package:gavhar_app/data/models/product/product_model.dart';
import 'package:gavhar_app/screens/produc/add_product_screen.dart';
import 'package:gavhar_app/screens/produc/info_screen.dart';
import 'package:gavhar_app/screens/produc/widget/product_item.dart';
import 'package:gavhar_app/screens/produc/widget/stagger_mygrid.dart';
import 'package:gavhar_app/utils/size_app.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // double b = 0.0;
    // scrollController.addListener(() {
    //   // debugPrint(scrollController.position.pixels.toString());
    //   double a = scrollController.position.pixels;
    //   if(a > -1){
    //     if (a > b) {
    //       globalAnimationController.reverse();
    //     } else if (a < b) {
    //       globalAnimationController.forward();
    //     }
    //     b = a;
    //     debugPrint(a.toString());
    //
    //   }
    // });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product_Screen"),
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
      body: StaggerGridMyWidget(
        scrollController: scrollController,
        child: List.generate(
          20,
          (index) {
            return ProductItem(
              onLongPress: () {},
              index: index,
              onTab: () {
                // debugPrint("Makkami");
                globalAnimationController.reverse();

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return InfoScreen(productModel: globalProduct);
                    },
                  ),
                ).then(
                  (value) {
                    globalAnimationController.forward();
                  },
                );
              },
              productModel: globalProduct,
            );
          },
        ),
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
  imageUrl: "assets/images/asd.png",
  price: 50000000000,
);
