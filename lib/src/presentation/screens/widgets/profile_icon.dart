import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutor_app/src/presentation/components/shimmer_profile_avatar.dart';
import '../../../logic/blocs/authetication/authentication_bloc.dart';

class ProfileIcon extends StatelessWidget {
  const ProfileIcon({
    Key? key,
    this.isSettings = false,
  }) : super(key: key);
  final bool isSettings;

  @override
  Widget build(BuildContext context) {
    final String? image = BlocProvider.of<AuthBloc>(context).state.image;
    return isSettings
        ? Container(
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 5,
                    spreadRadius: 4,
                  ),
                ]),
            padding: EdgeInsets.all(isSettings ? 20 : 50),
            child: Icon(
              Icons.person,
              size: isSettings ? 43 : 100,
            ),
          )
        : image == null || image.isEmpty
            ? Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 5,
                          spreadRadius: 4,
                        ),
                      ]),
                  padding: EdgeInsets.all(isSettings ? 20 : 50),
                  child: Icon(
                    Icons.person,
                    size: isSettings ? 43 : 100,
                  ),
                ),
              )
            : GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed("/view_change_image");
                },
                child: Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.white10,
                    radius: 110,
                    child: ClipOval(
                      child: CachedNetworkImage(
                        progressIndicatorBuilder: (context, url, progress) {
                          return const Center(child: ShimmerProfileAvatar());
                        },
                        imageUrl: image,
                        fit: BoxFit.cover,
                        height: 300,
                        width: 290,
                      ),
                    ),
                  ),
                ),
              );
  }
}
