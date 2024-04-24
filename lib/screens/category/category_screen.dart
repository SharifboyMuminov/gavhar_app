import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gavhar_app/blocs/category/category_bloc.dart';
import 'package:gavhar_app/blocs/category/category_state.dart';
import 'package:gavhar_app/data/local/local_varibals.dart';
import 'package:gavhar_app/screens/category/add_category_screen.dart';
import 'package:gavhar_app/screens/produc/widget/stagger_mygrid.dart';
import 'package:gavhar_app/utils/app_colors.dart';
import 'package:gavhar_app/utils/size_app.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Category Screen",
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
                    return const AddCategoryScreen();
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
      body: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (BuildContext context, CategoryState state) {
          if (state is ErrorCategoryState) {
            return Center(child: Text(state.errorText));
          }
          if (state is SuccessCategoryState) {
            return Stack(
              children: [
                StaggerGridMyWidget(
                  child: List.generate(20, (index) {
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: 10.he),
                      alignment: Alignment.bottomCenter,
                      height: index.isEven ? 200.he : 250.he,
                      decoration: BoxDecoration(
                        color: AppColors.c_FFFFFF,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.27),
                            blurRadius: 30,
                            spreadRadius: 1,
                            offset: const Offset(0, 17),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10.r),
                        image: DecorationImage(
                          image: NetworkImage(state.categories[index].imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Text(
                        state.categories[index].categoryName,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.c_FFFFFF,
                          fontWeight: FontWeight.w700,
                          fontSize: 20.sp,
                          shadows: [
                            BoxShadow(
                              color: Colors.amber.withOpacity(0.7),
                              blurRadius: 10,
                              spreadRadius: 10,
                              offset: const Offset(0, 0),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
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
