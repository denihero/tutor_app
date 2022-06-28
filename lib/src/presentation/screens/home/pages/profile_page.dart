import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          height: 200,
          width: 200,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(360),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xFFC2D1E5),
                  offset: Offset(0, -1),
                  blurRadius: 11,
                )
              ]),
          child: ProfileIcon(),
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
        const SizedBox(height: 67),
        Padding(
          padding: const EdgeInsets.only(left: 30, bottom: 7),
          child: Row(
            children: const [
              Text(
                "Просмотренные",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.04,
                ),
              ),
              Spacer(),
            ],
          ),
        ),
        Expanded(
          child: BlocBuilder<HistoryCubit, HistoryState>(
            builder: (context, state) {
              if(state is HistoryLoading){
                return const Center(
                    child: CircularProgressIndicator()
                );
              }
              if(state is HistoryError){
                return const Center(
                    child: Text('Something get wrong')
                );
              }
              if(state is HistorySuccess){
                final historyCourse = state.historyCourses;
                return ListView.builder(
                    itemCount: historyCourse.length,
                    itemBuilder: (BuildContext context, int index){
                      return CourseCard(
                        course: Course(
                            name: historyCourse[index].name,
                            categoryName: historyCourse[index].categoryName,
                            lessons: historyCourse[index].lessons,
                            images: historyCourse[index].images,
                            likes: historyCourse[index].likes,
                            id: historyCourse[index].id
                        ),
                      );
                    });
              }
              return Container();
            },

          ),
        ),
      ],
    );
  }
}
