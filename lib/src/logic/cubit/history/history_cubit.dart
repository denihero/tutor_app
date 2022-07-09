import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tutor_app/src/logic/api.dart';
import 'package:tutor_app/src/models/models.dart';
part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit() : super(HistoryInitial());

  getCubitViewedCourses(String token) async {
    try {
      emit(HistoryLoading());
      List<Course> course = await getViewedCourses(token);
      emit(HistorySuccess(historyCourses: course));
    } catch (e) {
      emit(HistoryError());
    }
  }
}
