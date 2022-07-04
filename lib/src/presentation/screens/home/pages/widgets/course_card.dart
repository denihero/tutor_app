import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
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
      child: Container(
        height: 105,
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
        child: Stack(
          children: [
            Row(
              children: [
                Container(
                  height: 105,
                  width: 130,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: widget.course.images![0].image!,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    bottom: 12,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.course.name ?? "",
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.04,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 17),
                        child: Row(
                          children: [
                            iconWithCountText(Icons.star_rounded,
                                "${widget.course.likes} лайков"),
                          ],
                        ),
                      ),
                      Text(
                        "${widget.course.lessons?.length} " +
                            rightLessonsCountName(
                                widget.course.lessons?.length ?? 0),
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.04,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(flex: 2),
              ],
            ),
            widget.isForFavoritePage
                ? Positioned(
                    bottom: 10,
                    right: 10,
                    child: LikeButton(
                      isLiked: true,
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
            size: 15,
            color: Colors.black,
          ),
          const SizedBox(width: 5),
          Text(
            text,
            style: const TextStyle(
              color: Color(0xFF878787),
              fontSize: 7,
              fontWeight: FontWeight.w400,
              letterSpacing: 1.04,
            ),
          ),
        ],
      );
}
