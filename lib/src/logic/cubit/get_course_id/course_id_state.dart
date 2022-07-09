part of 'course_id_cubit.dart';

abstract class CourseIdState extends Equatable {
  @override
  List<Object> get props => [];
}

class CoursesIdInitial extends CourseIdState {}

class CoursesIdLoading extends CourseIdState {}

class CoursesIdError extends CourseIdState {}

class CoursesIdLoaded extends CourseIdState {
  CoursesIdLoaded({required this.course});
  final Course course;

  @override
  List<Object> get props => [course];
}
