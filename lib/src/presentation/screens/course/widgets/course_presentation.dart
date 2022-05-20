import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:tutor_app/src/models/models.dart';

class CoursePresentation extends StatelessWidget {
  const CoursePresentation({Key? key, required this.course}) : super(key: key);

  final Course course;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 310,
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
                height: 200,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: CachedNetworkImage(
                  imageUrl:"https://tinypng.com/images/social/website.jpg" ,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 14),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  course.nameOfCourse!,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.04,
                  ),
                ),
              ),
              const SizedBox(height: 23),
              Padding(
                padding: const EdgeInsets.only(left: 23),
                child: Row(
                  children: [
                    iconWithText(Icons.star_rounded, 12.toString()),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            right: 20,
            bottom: 89,
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(360),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFC2D1E5).withOpacity(0.7),
                    offset: const Offset(0, -1),
                    blurRadius: 11,
                  ),
                ],
              ),
              child: Center(
                child: LikeButton(
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
          Positioned(
            right: 30,
            bottom: 24,
            child: Text(
              "${course.lessons?.length} " +
                  rightLessonsCountName(course.lessons?.length??1),
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                letterSpacing: 1.04,
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
