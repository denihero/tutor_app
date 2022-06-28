import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tutor_app/src/logic/api.dart';
import 'package:tutor_app/src/models/models.dart';

part 'course_id_state.dart';

class CourseIdCubit extends Cubit<CourseIdState> {
  CourseIdCubit() : super(CoursesIdInitial());

  getCourseCubitById(String token,int id) async{
    emit(CoursesIdLoading());
    try{
      Course course = await getCourseById(token, id);
      emit(CoursesIdLoaded(course: course));
    }catch(e,s){
      print(e);
      print(s);
      emit(CoursesIdError());
    }
  }
}
