import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gavhar_app/screens/category/add_category_screen.dart';
import 'package:gavhar_app/screens/widgets/my_navigator.dart';
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
        title: Text("CategoryScreen"),
        actions: [
          IconButton(
            onPressed: () {
              myNavigator(context, screen: AddCategoryScreen());
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
    );
  }
}
