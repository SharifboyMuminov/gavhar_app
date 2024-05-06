import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gavhar_app/blocs/basket/basket_bloc.dart';
import 'package:gavhar_app/blocs/basket/basket_state.dart';
import 'package:gavhar_app/data/enums/status_enum.dart';
import 'package:gavhar_app/utils/app_constans/app_constans.dart';
import 'package:gavhar_app/utils/size_app.dart';

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
      body: BlocBuilder<BasketProductBloc, BasketState>(
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
            return GridView.builder(
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
                return Image.network(state.products[index].imageUrls.first);
              },
            );
          }

          return const Center(child: CircularProgressIndicator.adaptive());
        },
      ),
    );
  }
}
