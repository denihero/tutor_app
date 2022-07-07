import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';


class ShimmerProfileAvatar extends StatelessWidget {
  const ShimmerProfileAvatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[200]!,
      child: const CircleAvatar(
        radius: 110,
        backgroundColor: Colors.white,
      ),
    );
  }
}
