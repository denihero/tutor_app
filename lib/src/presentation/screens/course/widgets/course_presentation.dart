import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_button/like_button.dart';
import 'package:sizer/sizer.dart';
import 'package:tutor_app/src/models/models.dart';

import '../../../../logic/blocs/authetication/authentication_bloc.dart';

class CoursePresentation extends StatefulWidget {
  const CoursePresentation({
    Key? key,
    required this.course,
    required this.isLiked,
    required this.onLikeTapped,
  }) : super(key: key);

  final Course course;
  final bool isLiked;
  final Function onLikeTapped;

  @override
  State<CoursePresentation> createState() => _CoursePresentationState();
}

class _CoursePresentationState extends State<CoursePresentation> {
  late String token;
  @override
  void initState() {
    super.initState();

    token = BlocProvider.of<AuthBloc>(context).state.token;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: 33.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFFC2D1E5),
            offset: Offset(0, -1),
            blurRadius: 11,
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 26.h,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: CachedNetworkImage(
                  imageUrl: "${widget.course.images?[0].image}",
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 2.h),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  widget.course.name!,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.04,
                  ),
                ),
              ),
              SizedBox(height: 3.h),
              Padding(
                padding: const EdgeInsets.only(
                  left: 23,
                  right: 23,
                  bottom: 20,
                ),
                child: Row(
                  children: [
                    iconWithText(
                        Icons.star_rounded, widget.course.likes.toString()),
                    const Spacer(),
                    Text(
                      "${widget.course.lessons?.length} " +
                          rightLessonsCountName(
                              widget.course.lessons?.length ?? 1),
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.04,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            right: 15,
            bottom: 75,
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(360),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFC2D1E5).withOpacity(0.7),
                    offset: const Offset(0, -3),
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Center(
                child: LikeButton(
                  isLiked: widget.isLiked,
                  onTap: (value) async {
                    widget.onLikeTapped();

                    return value = !value;
                  },
                  likeBuilder: (bool isLiked) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 1.3, left: 2.75),
                      child: Icon(
                        Icons.favorite_rounded,
                        color: isLiked ? const Color(0xFFFE793D) : Colors.grey,
                        size: 28,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String rightLessonsCountName(int count) {
    switch (count) {
      case 1:
        return "урок";
      case 2:
        return "урока";
      default:
        return "уроков";
    }
  }

  Widget iconWithText(IconData icon, String text) => Row(
        children: [
          Icon(
            icon,
            color: const Color(0xFF878787),
            size: 15,
          ),
          const SizedBox(width: 5),
          Text(
            text,
            style: const TextStyle(
              color: Color(0xFF878787),
              fontSize: 7,
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      );
}
