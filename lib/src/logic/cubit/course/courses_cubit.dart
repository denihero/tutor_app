import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tutor_app/src/models/models.dart';

import '../../api.dart';

part 'courses_state.dart';

class CoursesCubit extends Cubit<CoursesState> {
  CoursesCubit() : super(CoursesInitial());

  fetchCourseFromCategory(String categoryName,String token) async {
    emit(CoursesLoading());

    try {
      List<Course> courses = await getCourse(token);

      List<Course> filtered = courses
          .where((courses) => courses.categoryName == categoryName)
          .toList();

      emit(CoursesCompleted(courses: filtered));
    } catch (e) {
      print(e);
      emit(CoursesError());
    }
  }

  fetchCourse(String token) async {
    emit(CoursesLoading());
    try {
      List<Course> courses = await getCourse(token);
      emit(CoursesCompleted(courses: courses));
    } catch (e) {
      print(e);
      emit(CoursesError());
    }
  }

  @override
  void onChange(Change<CoursesState> change) {
    print(change);
    super.onChange(change);
  }
}
