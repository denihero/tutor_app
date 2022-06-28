part of 'favorite_cubit.dart';

abstract class FavoritesState extends Equatable {
  @override
  List<Object> get props => [];
}

class FavoritesInitial extends FavoritesState {}

class FavoritesLoading extends FavoritesState {}

class FavoritesEmpty extends FavoritesState {}

class FavoritesError extends FavoritesState {}

class FavoritesCompleted extends FavoritesState {
  FavoritesCompleted({required this.favoritesList});

  final List<SavedList> favoritesList;

  @override
  List<Object> get props => [favoritesList];
}
