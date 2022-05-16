
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tutor_app/src/models/models.dart';


part 'course__state.dart';


class SurveyCubit extends Cubit<SurveyState> {
  SurveyCubit() : super(SurveyInitial());




  // get_last(String email, String token) async {
  //   if (state.surveys.contains(Course(id: 1))) {
  //     state.surveys.removeLast();
  //   }
  //   var s = await getLastSurvey(email, token);
  //   List<Course> copySurvey = state.surveys.toList();
  //   copySurvey.add(s);
  //   emit(SurveyCompleted(surveys: copySurvey,hasMax: true));
  // }

  // fetch_surveys_stream(String token) async {
  //   emit(SurveyLoading());
  //   try {
  //     await get_surveys_stream_fixed(token).fold(
  //       Surveys(id: -1, title: "Hello"),
  //       ((previous, element) {
  //         if (element.id == -100) {
  //           List<Surveys> copySurvey = state.surveys.toList();
  //           emit(SurveyCompleted(surveys: copySurvey, hasMax: true));
  //         } else if (!state.surveys.contains(element) && !is_category_filter) {
  //           final newState = SurveyCompleted(surveys: [
  //             ...state.surveys,
  //             ...[element]
  //           ]);
  //           emit(newState);
  //         }
  //         return;
  //       }),
  //     );
  //   } on Empty {
  //     emit(SurveyEmpty());
  //   } on UnimplementedError {
  //     emit(SurveyError());
  //   }
  // }

  // fetch_surveys_stream_category(String category, String token) async {
  //   emit(SurveyLoading());
  //   try {
  //     await get_surveys_via_category_stream_fixed(token, category).fold(
  //       Surveys(id: -1, title: "Hello"),
  //       ((previous, element) {
  //         if (element.id == -100) {
  //           List<Surveys> copySurvey = state.surveys.toList();
  //           emit(SurveyCompleted(surveys: copySurvey, hasMax: true));
  //         } else if (!state.surveys.contains(element)) {
  //           final newState = SurveyCompleted(surveys: [
  //             ...state.surveys,
  //             ...[element]
  //           ]);
  //           emit(newState);
  //         }
  //         return;
  //       }),
  //     );
  //   } on Empty {
  //     emit(SurveyEmpty());
  //   } on UnimplementedError {
  //     emit(SurveyError());
  //   }
  // }


}
