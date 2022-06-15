part of 'course__cubit.dart';

@immutable
abstract class SurveyState extends Equatable {
  final List<Course> surveys;
  SurveyState({this.surveys = const <Course>[]});
  @override
  List<Object> get props => [surveys];
}

class SurveyInitial extends SurveyState {
  SurveyInitial({surveys = const <Course>[]}) : super(surveys: surveys);
}

class SurveyCompleted extends SurveyState {
  SurveyCompleted({
    surveys = const <Course>[],
  }) : super(surveys: surveys);
  @override
  List<Object> get props => [surveys];
}

class SurveyError extends SurveyState {}

class SurveyLoading extends SurveyState {}

class SurveyEmpty extends SurveyState {}
