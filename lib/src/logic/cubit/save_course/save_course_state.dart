part of 'save_course_cubit.dart';

abstract class SaveCourseState extends Equatable {
  const SaveCourseState();

  @override
  List<Object> get props => [];
}

class SaveCourseInitial extends SaveCourseState {}

class SaveCourseStateProcessing extends SaveCourseState {}

class SaveCourseStateProccesed extends SaveCourseState {}
