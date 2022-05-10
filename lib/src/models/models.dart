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

  Map<String, dynamic> toMap() {
    return {
      'title': this.title,
      'videoUrl': this.videoUrl,
      'definition': this.definition,
    };
  }

  factory Lesson.fromMap(Map<String, dynamic> map) {
    return Lesson(
      title: map['title'] as String,
      videoUrl: map['videoUrl'] as String,
      definition: map['definition'] as String,
    );
  }

//</editor-fold>
}

class Course {
  ImageProvider image;
  String title;
  double rating;
  int views, likes;
  List<Lesson> lessons;

//<editor-fold desc="Data Methods">

  Course({
    required this.image,
    required this.title,
    required this.rating,
    required this.views,
    required this.likes,
    required this.lessons,
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

  Map<String, dynamic> toMap() {
    return {
      'image': this.image,
      'title': this.title,
      'rating': this.rating,
      'views': this.views,
      'likes': this.likes,
      'lessons': this.lessons,
    };
  }

  factory Course.fromMap(Map<String, dynamic> map) {
    return Course(
      image: map['image'] as ImageProvider,
      title: map['title'] as String,
      rating: map['rating'] as double,
      views: map['views'] as int,
      likes: map['likes'] as int,
      lessons: (map['lessons'] as List).map((lesson) => Lesson.fromMap(lesson))
          as List<Lesson>,
    );
  }

  int get lessonsCount => lessons.length;
//</editor-fold>
}
