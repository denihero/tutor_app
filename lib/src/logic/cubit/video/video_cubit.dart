import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:video_player/video_player.dart';

part 'video_state.dart';

class VideoCubit extends Cubit<VideoState> {
  VideoCubit() : super(VideoInitial());

  loadVideoFromNetwork(String url) {
    emit(VideoLoading());

    VideoPlayerController controller = VideoPlayerController.network(url);

    controller.initialize().then((_) {
      emit(VideoLoaded(controller: controller));
    }).onError((error, stackTrace) {
      log(error.toString());
      log(stackTrace.toString());

      emit(VideoLoadError());
    });
  }
}
