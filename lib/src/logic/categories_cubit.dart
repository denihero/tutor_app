import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'blocs/authetication/api_request.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<Cat> {
  CategoriesCubit() : super(CategoriesInitial());
  getCategory(String token) async {
    log("Category:${state.categories}");
    try {
      var v = await get_categories(token);
      emit(Categories(v));
    } catch (e) {
      print(e);
      emit(CategoriesError());
    }
  }
}
