import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tutor_app/src/models/models.dart';

import '../../api.dart';

part 'courses_state.dart';

class CourcesCubit extends Cubit<CoursesState> {
  CourcesCubit() : super(CoursesInitial());

  fetchCourseFromCategory(String categoryName) async {
    emit(CoursesLoading());

    try {
      List<Course> courses = await getCourse();

      List<Course> filtered = courses
          .where((cource) => cource.categoryName == categoryName)
          .toList();

      emit(CoursesCompleted(courses: filtered));
    } catch (e) {
      print(e);
      emit(CoursesError());
    }
  }

  fetchCourse() async {
    emit(CoursesLoading());
    try {
      List<Course> courses = await getCourse();
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
