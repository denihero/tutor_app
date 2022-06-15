import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          child: ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) => Container()),
        ),
      ],
    );
  }
}
