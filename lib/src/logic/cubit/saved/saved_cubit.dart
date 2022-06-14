import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutor_app/src/logic/api.dart';
import 'package:tutor_app/src/models/models.dart';

part 'saved_state.dart';

class SavedCoursesCubit extends Cubit<SavedState> {
  SavedCoursesCubit() : super(SavedInitial());
  addSavedList(String token) async {
    try {
      emit(SavedLoading());
      List<SavedList> data = await getSavedCourse(token);
      emit(SavedCompleted(savedList: data));
    } catch (e) {
      emit(SavedError());
    }
  }
}
