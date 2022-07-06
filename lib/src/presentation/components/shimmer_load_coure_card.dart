import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';


class ShimmerLoadCardWidget extends StatelessWidget {
  const ShimmerLoadCardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 14.h,
      margin: const EdgeInsets.symmetric(
        vertical: 14,
        horizontal: 30,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFFC2D1E5),
            offset: Offset(1, 1),
          ),
          BoxShadow(
            color: Color(0xFFC2D1E5),
            offset: Offset(1, 1),
          ),
        ],
      ),
      child:Stack(
        children: [
          Row(
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[200]!,
                child: Container(
                  height: 14.h,
                  width: 34.w,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(
                width: 3.w,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[200]!,
                      child: Container(
                        width: 170,
                        height: 15,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                        ),

                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 17),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[200]!,
                        child: Container(
                          width: 80,
                          height: 15,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[200]!,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                        ),
                        width: 80,
                        height: 15,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(flex: 2),
            ],
          ),
        ],
      ) ,
    );
  }
}
