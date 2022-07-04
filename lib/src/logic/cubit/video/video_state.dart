part of 'video_cubit.dart';

abstract class VideoState extends Equatable {
  const VideoState();

  @override
  List<Object> get props => [];
}

class VideoInitial extends VideoState {}

class VideoLoadError extends VideoState {}

class VideoLoading extends VideoState {}

class VideoLoaded extends VideoState {
  final VideoPlayerController controller;

  const VideoLoaded({required this.controller});

  @override
  List<Object> get props => [controller];
}
