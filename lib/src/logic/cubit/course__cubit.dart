import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tutor_app/src/models/models.dart';

import '../blocs/authetication/api.dart';

part 'course__state.dart';

class SurveyCubit extends Cubit<SurveyState> {
  SurveyCubit() : super(SurveyInitial());

  fetchCourse() async {
    emit(SurveyLoading());
    try {
      List<Course> data = await getCourse();
      emit(SurveyCompleted(surveys: data));
    } catch (e) {
      emit(SurveyError());
    }
  }

  @override
  void onChange(Change<SurveyState> change) {
    print(change);
    super.onChange(change);
  }
}
