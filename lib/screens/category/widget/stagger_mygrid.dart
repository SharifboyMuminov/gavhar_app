import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gavhar_app/utils/size_app.dart';

class StaggerGridMyWidget extends StatelessWidget {
  const StaggerGridMyWidget({super.key, required this.child});

  final List<Widget> child;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(
          left: 20.we, right: 20.we, bottom: 100.he, top: 20.he),
      children: [
        //   StaggeredGridView.countBuilder(
        //   crossAxisCount: 4,
        //   itemCount: 8,
        //   itemBuilder: (BuildContext context, int index) =>
        //       Container(
        //         color: Colors.green,
        //         child: Center(
        //           child: CircleAvatar(
        //               backgroundColor: Colors.white, child: Text('$index')),
        //         ),
        //       ),
        //   staggeredTileBuilder: (int index) =>
        //       StaggeredTile.count(2, index.isEven ? 2 : 1),
        //   mainAxisSpacing: 4.0,
        //   crossAxisSpacing: 4.0,
        // );
        StaggeredGrid.count(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          children: child,
        ),
      ],
    );
  }
}
