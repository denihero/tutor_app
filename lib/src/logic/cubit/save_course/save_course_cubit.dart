import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '/src/logic/api.dart';

part 'save_course_state.dart';

class SaveCourseCubit extends Cubit<SaveCourseState> {
  SaveCourseCubit() : super(SaveCourseInitial());

  controlSaveCourse(String token, int id) async {
    emit(SaveCourseStateProcessing());

    await saveCourses(token, id);

    emit(SaveCourseStateProccesed());
  }
}
