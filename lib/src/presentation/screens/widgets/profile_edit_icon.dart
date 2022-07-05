import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tutor_app/src/presentation/screens/widgets/profile_icon.dart';
import '../../../logic/blocs/authetication/authentication_bloc.dart';

class ProfileEditIcon extends StatefulWidget {
  const ProfileEditIcon({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileEditIcon> createState() => _ProfileEditIconState();
}

class _ProfileEditIconState extends State<ProfileEditIcon> {
  @override
  Widget build(BuildContext context) {
    final String? image = BlocProvider.of<AuthBloc>(context).state.image;
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthLoading)
          // ignore: curly_braces_in_flow_control_structures
          return const Align(
            alignment: Alignment.centerLeft,
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          );
        return SizedBox(
          width: 150,
          child: Stack(
            clipBehavior: Clip.hardEdge,
            children: [
              image == null || image.isEmpty
                  ? GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => const ChangeImage()));
                      },
                      child: const ProfileIcon(
                        isSettings: true,
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => const ChangeImage()));
                      },
                      child: CircleAvatar(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.white,
                        radius: 43,
                        child: ClipOval(
                          child: CachedNetworkImage(
                            progressIndicatorBuilder:
                                (context, url, progress) => const Center(
                                    child: CircularProgressIndicator(
                              color: Colors.black,
                            )),
                            imageUrl: image,
                            fit: BoxFit.cover,
                            height: 300,
                            width: 300,
                          ),
                        ),
                      ),
                    ),
              Positioned(
                  left: 50,
                  top: 40,
                  child: Container(
                    padding: const EdgeInsets.all(7),
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
                    child: const Icon(
                      Icons.edit,
                      size: 26,
                    ),
                  )),
            ],
          ),
        );
      },
    );
  }
}

class ChangeImage extends StatefulWidget {
  const ChangeImage({Key? key}) : super(key: key);

  @override
  State<ChangeImage> createState() => _ChangeImageState();
}

class _ChangeImageState extends State<ChangeImage> {
  final ImagePicker _picker = ImagePicker();

  File? imageFile;
  pickImage() async {
    try {
      final image = await _picker.pickImage(
          source: ImageSource.gallery, imageQuality: 50);
      if (image == null) return;
      setState(() {
        imageFile = File(image.path);
      });
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final String? image = BlocProvider.of<AuthBloc>(context).state.image;
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return state is AuthLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              )
            : WillPopScope(
                onWillPop: () async => false,
                child: Scaffold(
                    backgroundColor: Colors.white,
                    appBar: AppBar(
                      title: const Text(
                        "View Image",
                      ),
                      backgroundColor: Colors.white,
                      actions: [
                        IconButton(
                          onPressed: pickImage,
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.black,
                          ),
                        ),
                      ],
                      leading: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                          size: 30,
                        ),
                        onPressed: () async {
                          if (imageFile != null) {
                            BlocProvider.of<AuthBloc>(context)
                                .add(AuthChangeInfo(imageFile));
                            // BlocProvider.of<SurveyCubit>(context)
                            //     .fetch_surveys_stream(
                            //     BlocProvider.of<AuthBloc>(context)
                            //         .state
                            //         .token);
                          }
                          Navigator.of(context).pop();
                        },
                      ),
                      elevation: 0,
                    ),
                    body: image == null || image.isEmpty && imageFile == null
                        ? const Center(
                            child: Text("None"),
                          )
                        : Center(
                            child: imageFile == null
                                ? image.isEmpty
                                    ? const Center(child: Text("None"))
                                    : Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 60),
                                        child: CachedNetworkImage(
                                          imageUrl: image,
                                          width: double.infinity,
                                          fit: BoxFit.fitWidth,
                                        ),
                                      )
                                : Padding(
                                    padding: const EdgeInsets.only(bottom: 60),
                                    child: Image.file(
                                      imageFile!,
                                      width: double.infinity,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                          )));
      },
    );
  }
}
