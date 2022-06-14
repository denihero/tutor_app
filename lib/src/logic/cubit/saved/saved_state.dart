part of 'saved_cubit.dart';

abstract class SavedState extends Equatable {
  const SavedState();
}

class SavedInitial extends SavedState {
  @override
  List<Object> get props => [];
}

class SavedLoading extends SavedState {
  @override
  List<Object> get props => [];
}

class SavedError extends SavedState {
  @override
  List<Object> get props => [];
}

class SavedCompleted extends SavedState {
  final List<SavedList> savedList;

  const SavedCompleted({required this.savedList});

  @override
  List<Object> get props => [];
}
