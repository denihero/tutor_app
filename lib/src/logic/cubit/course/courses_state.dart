part of 'courses_cubit.dart';

@immutable
abstract class CoursesState extends Equatable {
  @override
  List<Object> get props => [];
}

class CoursesInitial extends CoursesState {}

class CoursesCompleted extends CoursesState {
  CoursesCompleted({required this.courses});

  final List<Course> courses;

  @override
  List<Object> get props => [courses];
}

class CoursesError extends CoursesState {}

class CoursesLoading extends CoursesState {}

class CoursesEmpty extends CoursesState {}
