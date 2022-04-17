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
        margin: EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 30,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
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
                  width: 136,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image(
                    image: widget.course.image,
                    fit: BoxFit.cover,
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(
                    top: 10,
                    bottom: 12,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.course.title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.04,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 17),
                        child: Row(
                          children: [
                            iconWithCountText(Icons.group,
                                "${widget.course.views} просмотров"),
                            iconWithCountText(Icons.star_rounded,
                                "${widget.course.likes} лайков"),
                          ],
                        ),
                      ),
                      Text(
                        "${widget.course.lessonsCount} " +
                            rightLessonsCountName(widget.course.lessonsCount),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.04,
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(flex: 2),
              ],
            ),
            widget.isForFavoritePage
                ? Positioned(
                    top: 6,
                    right: 10,
                    child: LikeButton(
                      isLiked: true,
                      likeBuilder: (bool isLiked) {
                        return Icon(
                          Icons.favorite_rounded,
                          color: isLiked ? Color(0xFFFE793D) : Colors.grey,
                          size: 28,
                        );
                      },
                    ),
                  )
                : SizedBox(),
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
          SizedBox(width: 5),
          Text(
            text,
            style: TextStyle(
              color: Color(0xFF878787),
              fontSize: 7,
              fontWeight: FontWeight.w400,
              letterSpacing: 1.04,
            ),
          ),
        ],
      );
}
