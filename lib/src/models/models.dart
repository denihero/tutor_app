import 'package:flutter/material.dart';

class Lesson {
  String title, videoUrl, definition;

//<editor-fold desc="Data Methods">

  Lesson({
    required this.title,
    required this.videoUrl,
    required this.definition,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Lesson &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          videoUrl == other.videoUrl &&
          definition == other.definition);

  @override
  int get hashCode => title.hashCode ^ videoUrl.hashCode ^ definition.hashCode;

  @override
  String toString() {
    return 'Lesson{' +
        ' title: $title,' +
        ' videoUrl: $videoUrl,' +
        ' definition: $definition,' +
        '}';
  }

  Lesson copyWith({
    String? title,
    String? videoUrl,
    String? definition,
  }) {
    return Lesson(
      title: title ?? this.title,
      videoUrl: videoUrl ?? this.videoUrl,
      definition: definition ?? this.definition,
    );
  }

  dynamic toJson() {
    return {
      'title': title,
      'videoUrl': videoUrl,
      'definition': definition,
    };
  }

  factory Lesson.fromJson(dynamic json) {
    return Lesson(
      title: json['title'] as String,
      videoUrl: json['videoUrl'] as String,
      definition: json['definition'] as String,
    );
  }

//</editor-fold>
}

class Course {
  ImageProvider? image;
  String? title;
  double? rating;
  int? views, likes;
  List<Lesson>? lessons;

//<editor-fold desc="Data Methods">

  Course({
    this.image,
    this.title,
    this.rating,
    this.views,
    this.likes,
    this.lessons,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Course &&
          runtimeType == other.runtimeType &&
          image == other.image &&
          title == other.title &&
          rating == other.rating &&
          views == other.views &&
          likes == other.likes &&
          lessons == other.lessons);

  @override
  int get hashCode =>
      image.hashCode ^
      title.hashCode ^
      rating.hashCode ^
      views.hashCode ^
      likes.hashCode ^
      lessons.hashCode;

  @override
  String toString() {
    return 'Course{' +
        ' image: $image,' +
        ' title: $title,' +
        ' rating: $rating,' +
        ' views: $views,' +
        ' likes: $likes,' +
        ' lessons: $lessons,' +
        '}';
  }

  Course copyWith({
    ImageProvider? image,
    String? title,
    double? rating,
    int? views,
    int? likes,
    List<Lesson>? lessons,
  }) {
    return Course(
      image: image ?? this.image,
      title: title ?? this.title,
      rating: rating ?? this.rating,
      views: views ?? this.views,
      likes: likes ?? this.likes,
      lessons: lessons ?? this.lessons,
    );
  }

  dynamic toJson() {
    return {
      'image': image,
      'title': title,
      'rating': rating,
      'views': views,
      'likes': likes,
      'lessons': lessons,
    };
  }

  factory Course.fromJson(dynamic json) {
    return Course(
      image: json['image'] as ImageProvider,
      title: json['title'] as String,
      rating: json['rating'] as double,
      views: json['views'] as int,
      likes: json['likes'] as int,
      lessons: (json['lessons'] as List).map((lesson) => Lesson.fromJson(lesson))
          as List<Lesson>,
    );
  }

  int get lessonsCount => lessons!.length;
//</editor-fold>
}
