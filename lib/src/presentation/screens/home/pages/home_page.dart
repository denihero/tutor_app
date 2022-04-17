import 'package:flutter/material.dart';
import 'package:tutor_app/src/models/models.dart';
import 'package:tutor_app/src/presentation/screens/home/pages/widgets/course_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 41,
            margin: EdgeInsets.only(left: 17, bottom: 43),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) =>
                  CategoryButton(isSelected: true, name: "Математика"),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 20,
              itemBuilder: (BuildContext context, int index) => CourseCard(
                course: Course(
                  image: NetworkImage(
                      "https://timeweb.com/ru/community/article/3c/3c0cefa6f99fda8d9596da474fc7e264.jpg"),
                  title: "Python",
                  rating: 4.5,
                  views: 10,
                  likes: 1,
                  lessons: [
                    Lesson(
                        title: "Basics",
                        videoUrl: "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
                        definition:
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
                    Lesson(
                        title: "Begin",
                        videoUrl: "",
                        definition:
                            "Aboba aboba aboba aboba aboba aboba aboba aboba aboba aboba aboba aboba aboba aboba aboba"),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryButton extends StatefulWidget {
  const CategoryButton({
    Key? key,
    required this.isSelected,
    required this.name,
    this.color = const Color(0xFFFAFAFA),
    this.selectedColor = const Color(0xFFFE793D),
  }) : super(key: key);

  final bool isSelected;
  final String name;
  final Color color, selectedColor;

  @override
  State<CategoryButton> createState() => _CategoryButtonState();
}


class _CategoryButtonState extends State<CategoryButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 13),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: widget.isSelected ? widget.selectedColor : widget.color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          widget.name,
          style: TextStyle(
            color: widget.isSelected ? Colors.white : Colors.black,
            fontSize: 9,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.04,
          ),
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    throw UnimplementedError();
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    throw UnimplementedError();
  }

}