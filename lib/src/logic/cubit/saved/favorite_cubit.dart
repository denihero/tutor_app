import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutor_app/src/logic/api.dart';
import 'package:tutor_app/src/models/models.dart';
import 'dart:developer';

part 'favorutes_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(FavoritesInitial());
  addSavedList(String token) async {
    try {
      emit(FavoritesLoading());
      List<SavedList> data = await getSavedCourse(token);
      log('$data');
      if (data.isNotEmpty) {
        emit(FavoritesCompleted(favoritesList: data));
      } else {
        emit(FavoritesEmpty());
      }
    } catch (e,s) {
      print(e);
      print(s);
      emit(FavoritesError());
    }
  }
}
