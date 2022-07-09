import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../models/models.dart';
import '../../api.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  fetchSearch(String toFind, String token) async {
    emit(SearchProcessing());

    try {
      List<Course> courses = await getCourse(token);

      List<Course> filtered = courses.where(
        (survey) {
          return survey.name!.toLowerCase().contains(toFind.toLowerCase()) ||
              survey.categoryName!.toLowerCase().contains(toFind.toLowerCase());
        },
      ).toList();

      if (filtered.isNotEmpty) {
        emit(SearchCompleted(courses: filtered));
      } else {
        emit(SearchEmpty());
      }
    } catch (e) {
      emit(SearchError());
    }
  }

  @override
  void onChange(Change<SearchState> change) {
    super.onChange(change);
  }
}
