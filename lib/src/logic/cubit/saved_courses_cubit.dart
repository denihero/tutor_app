import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutor_app/src/logic/blocs/authetication/api_request.dart';
import 'package:tutor_app/src/models/models.dart';

part 'saved_courses_state.dart';

class SavedCoursesCubit extends Cubit<SavedCoursesState> {
  SavedCoursesCubit() : super(SavedCoursesInitial());

  addSavedList(String token) async {
    try {
      emit(SavedCoursesLoading());
      List<SavedList> data = await getSavedCourse(token);
      if (data[0].course!.isEmpty) {
        emit(SavedCoursesEmpty());
      } else {
        emit(SavedCoursesCompleted(savedList: data));
      }
    } catch (e) {
      emit(SavedCoursesError());
    }
  }
}
