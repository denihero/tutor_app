import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutor_app/src/logic/cubit/search/search_cubit.dart';

import '../../models/models.dart';
import '../screens/home/pages/widgets/course_card.dart';

class CustomSearch extends StatelessWidget {
  const CustomSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextFormField(
        onTap: () {
          showSearch(
            context: context,
            delegate: CustomSearchDelegate(
              searchCubit: BlocProvider.of<SearchCubit>(context),
            ),
          );
          FocusManager.instance.primaryFocus?.unfocus();
        },
        cursorHeight: 16,
        autofocus: false,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.04,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 2, left: 10),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32)),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32)),
            borderSide: BorderSide(color: Color(0xFFFE793D)),
          ),
          filled: true,
          fillColor: Colors.grey.withOpacity(0.2),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(left: 6),
            child: CircleAvatar(
                radius: 10,
                backgroundColor: const Color(0xFFFE793D),
                child: IconButton(
                  icon: const Icon(Icons.search),
                  color: Colors.white,
                  onPressed: () {},
                )),
          ),
          hintStyle: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: Colors.black.withOpacity(0.46),
            letterSpacing: 1.04,
          ),
          hintText: "Живой поиск",
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  final SearchCubit searchCubit;

  CustomSearchDelegate({required this.searchCubit});

  late String queryString;

  @override
  ThemeData appBarTheme(BuildContext context) {
    return super.appBarTheme(context).copyWith(
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
          ),
        );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear)),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
          FocusManager.instance.primaryFocus?.unfocus();
        },
        icon: const Icon(Icons.arrow_back_outlined));
  }

  @override
  Widget buildResults(BuildContext context) {
    queryString = query;
    searchCubit.fetchSearch(query);

    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state is SearchProcessing) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.orange,
            ),
          );
        }

        if (state is SearchCompleted) {
          var courses = state.courses;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 25),
                child: Text(
                  "Результаты для “$queryString”",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.03),
                ),
              ),
              Divider(
                thickness: 2,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: courses.length,
                    itemBuilder: (BuildContext context, int index) {
                      Course course = courses[index];
                      return CourseCard(
                        course: Course(
                            nameOfCourse: course.nameOfCourse,
                            category: course.category,
                            lessons: course.lessons,
                            images: course.images,
                            likes: course.likes),
                      );
                    }),
              ),
            ],
          );
        }

        if (state is SearchEmpty) {
          return Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              "Результаты для “$queryString” не найдены",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.03),
            ),
          );
        }

        return Column(
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 60,
              color: Colors.black38,
            ),
            Text(
              "Something get wrong",
              style: TextStyle(
                fontSize: 24,
                color: Colors.black38,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Column(
      children: [],
    );
  }
}
