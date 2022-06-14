part of 'saved_courses_cubit.dart';

abstract class SavedCoursesState extends Equatable {
  const SavedCoursesState();
}

class SavedCoursesInitial extends SavedCoursesState {
  @override

  List<Object> get props => [];
}

class SavedCoursesLoading extends SavedCoursesState {
  @override
  List<Object> get props => [];
}

class SavedCoursesError extends SavedCoursesState {
  @override
  List<Object> get props => [];
}
class SavedCoursesCompleted extends SavedCoursesState {
  final List<SavedList> savedList;

  const SavedCoursesCompleted({required this.savedList});

  @override
  List<Object> get props => [];
}