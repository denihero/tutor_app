import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutor_app/src/logic/api.dart';
import 'package:tutor_app/src/models/models.dart';

part 'favorutes_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(FavoritesInitial());
  addSavedList(String token) async {
    try {
      emit(FavoritesLoading());
      List<SavedList> data = await getSavedCourse(token);
      List<Course> courses = [];

      if (courses.isNotEmpty) {
        emit(FavoritesCompleted(favoritesList: courses));
      } else {
        emit(FavoritesEmpty());
      }
    } catch (e) {
      emit(FavoritesError());
    }
  }
}
