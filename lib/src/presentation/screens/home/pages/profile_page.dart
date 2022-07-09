import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:tutor_app/src/logic/cubit/history/history_cubit.dart';
import 'package:tutor_app/src/models/models.dart';
import 'package:tutor_app/src/presentation/screens/home/pages/widgets/course_card.dart';
import 'package:tutor_app/src/presentation/screens/widgets/profile_icon.dart';

import '../../../../logic/blocs/authetication/authentication_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 16.h,
          width: 34.w,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(360),
          ),
          child: const ProfileIcon(),
        ),
        const SizedBox(height: 44),
        Text(
          "${BlocProvider.of<AuthBloc>(context).state.name} ${BlocProvider.of<AuthBloc>(context).state.surname}",
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.04,
          ),
        ),
        SizedBox(height: 5.h),
        Padding(
          padding: const EdgeInsets.only(left: 30, bottom: 7),
          child: Row(
            children: [
              Text(
                "Просмотренные",
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.04,
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
        Expanded(
          child: BlocBuilder<HistoryCubit, HistoryState>(
            builder: (context, state) {
              if (state is HistoryLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is HistoryError) {
                return const Center(child: Text('Something get wrong'));
              }
              if (state is HistorySuccess) {
                final historyCourse = state.historyCourses;
                return ListView.builder(
                    itemCount: historyCourse.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CourseCard(
                        course: Course(
                            name: historyCourse[index].name,
                            categoryName: historyCourse[index].categoryName,
                            lessons: historyCourse[index].lessons,
                            images: historyCourse[index].images,
                            likes: historyCourse[index].likes,
                            id: historyCourse[index].id),
                      );
                    });
              }
              return const SizedBox();
            },
          ),
        ),
      ],
    );
  }
}
