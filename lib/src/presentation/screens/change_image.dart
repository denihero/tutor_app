import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../logic/blocs/authetication/authentication_bloc.dart';

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
            : Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  title: const Text(
                    "View Image",
                    style: TextStyle(color: Colors.black),
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
                      Icons.save,
                      color: Colors.black,
                      size: 30,
                    ),
                    onPressed: () async {
                      if (imageFile != null) {
                        BlocProvider.of<AuthBloc>(context)
                            .add(AuthChangeInfo(imageFile));
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
                                    padding: const EdgeInsets.only(bottom: 60),
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
                      ),
              );
      },
    );
  }
}
