import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gavhar_app/blocs/deleted_ones/delete_ones_bloc.dart';
import 'package:gavhar_app/blocs/deleted_ones/deleted_ones_state.dart';
import 'package:gavhar_app/utils/app_constans/app_constans.dart';
import 'package:gavhar_app/utils/size_app.dart';

class DeletedOnesScreen extends StatefulWidget {
  const DeletedOnesScreen({super.key});

  @override
  State<DeletedOnesScreen> createState() => _DeletedOnesScreenState();
}

class _DeletedOnesScreenState extends State<DeletedOnesScreen> {
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
      ),
      body: BlocBuilder<DeletedOnesBloc, DeletedOnesState>(
        builder: (BuildContext context, DeletedOnesState state) {
          if (state is ErrorDeletedOnesState) {
            return Center(child: Text(state.errorText));
          }

          if (state is SuccessDeletedOnesState) {
            if (state.products.isEmpty) {
              return Center(
                  child: Image.asset(
                AppConst.emptyData,
                width: 250.we,
              ));
            }
          }

          return const Center(child: CircularProgressIndicator.adaptive());
        },
      ),
    );
  }
}
