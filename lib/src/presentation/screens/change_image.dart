import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../logic/blocs/authetication/authentication_bloc.dart';
import '../../logic/cubit/course__cubit.dart';

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
        this.imageFile = File(image.path);
      });
      print(imageFile?.path);
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final String? image = BlocProvider.of<AuthBloc>(context).state.image;
    bool is_loading = false;
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
                  title: Text(
                    "View Image"
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
                      var val = BlocProvider.of<AuthBloc>(context).state;
                      if (imageFile != null) {
                        BlocProvider.of<AuthBloc>(context)
                            .add(AuthChangeInfo(imageFile));
                        final nextState =
                        await BlocProvider.of<AuthBloc>(context)
                            .stream
                            .firstWhere((element) =>
                        element is AuthSuccess ||
                            element is AuthError);
                      }
                      Navigator.of(context).pop();
                    },
                  ),
                  elevation: 0,
                ),
                body: image == null || image.isEmpty && imageFile == null
                    ? const Center(
                  child: Text(
                    "None"
                  ),
                )
                    : Center(
                  child: imageFile == null
                      ? image == null || image.isEmpty
                      ? Center(
                      child: Text("None"))
                      : Padding(
                    padding:
                    const EdgeInsets.only(bottom: 60),
                    child: CachedNetworkImage(
                      imageUrl: image ?? "",
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
