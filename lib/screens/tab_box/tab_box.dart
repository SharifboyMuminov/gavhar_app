import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gavhar_app/data/local/local_varibals.dart';
import 'package:gavhar_app/screens/category/category_screen.dart';
import 'package:gavhar_app/screens/produc/produc_screen.dart';
import 'package:gavhar_app/screens/tab_box/cubits/tab_box_cubit.dart';
import 'package:gavhar_app/utils/app_colors.dart';
import 'package:gavhar_app/utils/size_app.dart';

import '../request/request_screen.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  final List<Widget> _screens = const [
    CategoryScreen(),
    ProductScreen(),
    RequestScreen(),
  ];

  @override
  void initState() {
    globalAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));

    animation = Tween<double>(begin: -100.0, end: 0.0)
        .animate(globalAnimationController);

    globalAnimationController.forward();
    globalAnimationController.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TabBoxCubit(),
      child: BlocBuilder<TabBoxCubit, int>(
        builder: (BuildContext context, int state) {
          return Scaffold(
            body: Stack(
              children: [
                IndexedStack(
                  index: context.watch<TabBoxCubit>().state,
                  children: _screens,
                ),
                Positioned(
                  bottom: animation.value,
                  left: 0,
                  right: 0,
                  child: Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: 20.we, vertical: 20.he),
                    padding: EdgeInsets.symmetric(
                        horizontal: 20.we, vertical: 10.he),
                    decoration: BoxDecoration(
                      color: AppColors.c_FFFFFF,
                      borderRadius: BorderRadius.circular(15.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 30,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _getButton(
                          onTab: () {
                            context.read<TabBoxCubit>().changeValue(value: 0);
                          },
                          icon: Icons.home,
                          active: context.read<TabBoxCubit>().state == 0,
                        ),
                        _getButton(
                          onTab: () {
                            context.read<TabBoxCubit>().changeValue(value: 1);
                          },
                          icon: Icons.shopping_basket,
                          active: context.read<TabBoxCubit>().state == 1,
                        ),
                        _getButton(
                          onTab: () {
                            context.read<TabBoxCubit>().changeValue(value: 2);
                          },
                          icon: Icons.request_page,
                          active: context.read<TabBoxCubit>().state == 2,
                        ),
                        // _getButton(
                        //   onTab: () {
                        //     provide.setActiveScreen(3);
                        //   },
                        //   icon: Icons.supervised_user_circle_sharp,
                        //   active: provideListen.activeScreen == 3,
                        // ),
                        // _getButton(
                        //   onTab: () {
                        //     provide.setActiveScreen(4);
                        //   },
                        //   icon: Icons.person,
                        //   active: provideListen.activeScreen == 4,
                        // ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    globalAnimationController.dispose();
    super.dispose();
  }

  Widget _getButton(
      {required VoidCallback onTab,
      required IconData icon,
      required bool active}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: onTab,
          icon: Icon(
            icon,
            size: 24.sp,
          ),
        ),
        if (active)
          Container(
            width: 5.we,
            height: 5.we,
            decoration: const BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
            ),
          ),
      ],
    );
  }
}
