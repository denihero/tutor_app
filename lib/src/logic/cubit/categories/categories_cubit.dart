import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../api.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<Cat> {
  CategoriesCubit() : super(CategoriesInitial());
  getCategory(String token) async {
    try {
      var v = await getCategories(token);
      emit(Categories(v));
    } catch (e) {
      emit(CategoriesError());
    }
  }
}
