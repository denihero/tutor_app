import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../models/models.dart';
import '../../api.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  fetchSearch(String toFind) async {
    emit(SearchProcessing());

    try {
      List<Course> courses = await getCourse();

      List<Course> filtered = courses
          .where((survey) =>
              survey.name!.toLowerCase().contains(toFind.toLowerCase()))
          .toList();

      if (filtered.isNotEmpty) {
        emit(SearchCompleted(courses: filtered));
      } else {
        emit(SearchEmpty());
      }
    } catch (e) {
      print(e);
      emit(SearchError());
    }
  }

  @override
  void onChange(Change<SearchState> change) {
    print(change);
    super.onChange(change);
  }
}
