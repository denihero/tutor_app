part of 'search_cubit.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchProcessing extends SearchState {}

class SearchCompleted extends SearchState {
  SearchCompleted({required this.courses});

  final List<Course> courses;

  @override
  List<Object> get props => [courses];
}

class SearchError extends SearchState {}

class SearchEmpty extends SearchState {}
