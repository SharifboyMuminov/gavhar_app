import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gavhar_app/blocs/basket/basket_bloc.dart';
import 'package:gavhar_app/blocs/basket/basket_event.dart';
import 'package:gavhar_app/blocs/category/category_bloc.dart';
import 'package:gavhar_app/blocs/category/category_event.dart';
import 'package:gavhar_app/blocs/like_product/like_product_bloc.dart';
import 'package:gavhar_app/blocs/like_product/like_product_event.dart';
import 'package:gavhar_app/blocs/product/product_bloc.dart';
import 'package:gavhar_app/blocs/product/product_event.dart';
import 'package:gavhar_app/data/repositories/category_repository.dart';
import 'package:gavhar_app/data/repositories/product_repository.dart';
import 'package:gavhar_app/server/firebase_options.dart';
import 'package:gavhar_app/screens/splash/splash_screen.dart';
import 'package:gavhar_app/utils/app_colors.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) =>
                ProductBloc(ProductRepository())..add(ProductCallEvent())),
        BlocProvider(
            create: (_) =>
                CategoryBloc(CategoryRepository())..add(CategoryCallEvent())),
        BlocProvider(
            create: (_) => LikeProductBloc()..add(LikeProductCallEvent())),
        BlocProvider(
            create: (_) => BasketProductBloc()..add(CallBasketProductsEvent())),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        ScreenUtil.init(context);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            scaffoldBackgroundColor: AppColors.c_FFFFFF,
            appBarTheme: const AppBarTheme(
              backgroundColor: AppColors.c_FFFFFF,
            ),
          ),
          home: child,
        );
      },
      child: const SplashScreen(),
    );
  }
}
