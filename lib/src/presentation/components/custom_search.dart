import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutor_app/src/logic/blocs/authetication/authentication_bloc.dart';
import 'package:tutor_app/src/logic/cubit/search/search_cubit.dart';
import 'package:sizer/sizer.dart';
import 'package:tutor_app/src/presentation/screens/home/pages/widgets/shimmer_load_coure_card.dart';
import '../../models/models.dart';
import '../screens/home/pages/widgets/course_card.dart';

class CustomSearch extends StatelessWidget {
  const CustomSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 4.5.h,
      width: 65.w,
      child: TextFormField(
        readOnly: true,
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
        style: TextStyle(
          fontSize: 10.sp,
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
            padding: EdgeInsets.only(left: 0.9.h),
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
            fontSize: 9.sp,
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
          appBarTheme: const AppBarTheme(
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
    String token = BlocProvider.of<AuthBloc>(context).state.token;
    queryString = query;
    searchCubit.fetchSearch(query,token);

   return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state is SearchProcessing) {
          return ListView.builder(
            itemCount: 5,
            itemBuilder: (context,index){
              return ShimmerLoadCardWidget();
            },
          );
        }if (state is SearchCompleted) {
          var courses = state.courses;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Text(
                  "Результаты для “$queryString”",
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.03),
                ),
              ),
              const Divider(
                thickness: 2,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: courses.length,
                    itemBuilder: (BuildContext context, int index) {
                      Course course = courses[index];
                      return CourseCard(
                        course: Course(
                            name: course.name,
                            categoryName: course.categoryName,
                            lessons: course.lessons,
                            images: course.images,
                            likes: course.likes,
                            id: course.id),
                      );
                    }),
              ),
            ],
          );
        }

        if (state is SearchEmpty) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              "Результаты для “$queryString” не найдены",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.03),
            ),
          );
        }

        return Column(
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 60.sp,
              color: Colors.black38,
            ),
            Text(
              "Something get wrong",
              style: TextStyle(
                fontSize: 24.sp,
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
    String token = BlocProvider.of<AuthBloc>(context).state.token;
    queryString = query;
    searchCubit.fetchSearch(query,token);

    if(queryString.length > 2)
      {
        return BlocBuilder<SearchCubit, SearchState>(
          builder: (context, state) {
            if (state is SearchProcessing) {
              return ListView.builder(
                itemCount: 5,
                itemBuilder: (context,index){
                  return const ShimmerLoadCardWidget();
                },
              );
            }if (state is SearchCompleted) {
              var courses = state.courses;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Text(
                      "Результаты для “$queryString”",
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.03),
                    ),
                  ),
                  const Divider(
                    thickness: 2,
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: courses.length,
                        itemBuilder: (BuildContext context, int index) {
                          Course course = courses[index];
                          return CourseCard(
                            course: Course(
                                name: course.name,
                                categoryName: course.categoryName,
                                lessons: course.lessons,
                                images: course.images,
                                likes: course.likes,
                                id: course.id),
                          );
                        }),
                  ),
                ],
              );
            }

            if (state is SearchEmpty) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  "Результаты для “$queryString” не найдены",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.03),
                ),
              );
            }

            return Column(
              children: [
                Icon(
                  Icons.error_outline_rounded,
                  size: 60.sp,
                  color: Colors.black38,
                ),
                Text(
                  "Something get wrong",
                  style: TextStyle(
                    fontSize: 24.sp,
                    color: Colors.black38,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          },
        );
      }
    return Container();
  }
}
