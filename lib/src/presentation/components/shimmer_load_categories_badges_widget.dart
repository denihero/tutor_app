import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoadCategoriesBadgesWidget extends StatelessWidget {
  const ShimmerLoadCategoriesBadgesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[200]!,
      child: Container(
        width: 100,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white
        ),
      ),
    );
  }
}
