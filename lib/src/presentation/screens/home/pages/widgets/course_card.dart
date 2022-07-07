import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:like_button/like_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:tutor_app/src/models/models.dart';
import 'package:tutor_app/src/presentation/screens/course/course_screen.dart';

class CourseCard extends StatefulWidget {
  const CourseCard({
    Key? key,
    required this.course,
    this.isForFavoritePage = false,
  }) : super(key: key);

  final Course course;
  final bool isForFavoritePage;

  @override
  State<CourseCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CourseScreen(course: widget.course),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 30
        ),
        child: Material(
          color: Colors.white,
          elevation: 3,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: 14.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20)
            ),
            child: Stack(
              children: [
                Row(
                  children: [
                    Container(
                      height: 14.h,
                      width: 35.w,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: widget.course.images![0].image!,
                        fit: BoxFit.cover,
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
                          SizedBox(
                            width: 45.w,
                            child: Text(
                              widget.course.name ?? "",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.04,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 13),
                            child: Row(
                              children: [
                                iconWithCountText(Icons.star_rounded,
                                    "${widget.course.likes} лайков"),
                              ],
                            ),
                          ),
                          const Spacer(
                            flex: 3,
                          ),
                          Text(
                            "${widget.course.lessons?.length} " +
                                rightLessonsCountName(
                                    widget.course.lessons?.length ?? 0),
                            style: TextStyle(
                              fontSize: 9.sp,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.04,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
                widget.isForFavoritePage
                    ? Positioned(
                        bottom: 10,
                        right: 10,
                        child: LikeButton(
                          isLiked: true,
                          onTap: (value) async {
                            return true;
                          },
                          likeBuilder: (bool isLiked) {
                            return Icon(
                              Icons.favorite_rounded,
                              color:
                                  isLiked ? const Color(0xFFFE793D) : Colors.grey,
                              size: 28,
                            );
                          },
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
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

  Widget iconWithCountText(IconData icon, String text) => Row(
        children: [
          Icon(
            icon,
            size: 7.sp,
            color: Colors.black,
          ),
          const SizedBox(width: 5),
          Text(
            text,
            style: TextStyle(
              color: const Color(0xFF878787),
              fontSize: 7.sp,
              fontWeight: FontWeight.w400,
              letterSpacing: 1.04,
            ),
          ),
        ],
      );
}
