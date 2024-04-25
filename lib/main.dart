import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gavhar_app/blocs/category/category_bloc.dart';
import 'package:gavhar_app/blocs/category/category_event.dart';
import 'package:gavhar_app/blocs/deleted_ones/delete_ones_bloc.dart';
import 'package:gavhar_app/blocs/deleted_ones/deleted_ones_event.dart';
import 'package:gavhar_app/blocs/product/product_bloc.dart';
import 'package:gavhar_app/blocs/product/product_event.dart';
import 'package:gavhar_app/cubits/image/image_cubit.dart';
import 'package:gavhar_app/server/firebase_options.dart';
import 'package:gavhar_app/screens/splash/splash_screen.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ProductBloc()..add(ProductCallEvent())),
        BlocProvider(create: (_) => ImageCubit()),
        BlocProvider(create: (_) => CategoryBloc()..add(CategoryCallEvent())),
        BlocProvider(
            create: (_) => DeletedOnesBloc()..add(DeletedOnesCallEvent())),
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
          theme: ThemeData(useMaterial3: true),
          home: child,
        );
      },
      child: const SplashScreen(),
    );
  }
}
