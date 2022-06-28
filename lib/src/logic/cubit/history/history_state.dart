part of 'history_cubit.dart';

abstract class HistoryState extends Equatable {
  @override
  List<Object> get props => [];
}

class HistoryInitial extends HistoryState {}
class HistoryLoading extends HistoryState{}
class HistorySuccess extends HistoryState{

  HistorySuccess({required this.historyCourses});
  final List<Course> historyCourses;
}
class HistoryError extends HistoryState{}
