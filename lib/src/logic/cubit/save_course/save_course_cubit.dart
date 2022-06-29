import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'save_course_state.dart';

class SaveCourseCubit extends Cubit<SaveCourseState> {
  SaveCourseCubit() : super(SaveCourseInitial());
}
