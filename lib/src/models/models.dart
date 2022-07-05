// To parse this JSON data, do
//
//     final course = courseFromJson(jsonString);

import 'dart:convert';

List<Course> courseFromJson(String str) =>
    List<Course>.from(json.decode(str).map((x) => Course.fromJson(x)));

String courseToJson(List<Course> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Course {
  Course({
    required this.id,
    this.name,
    this.categoryName,
    this.images,
    this.lessons,
    required this.likes,
  });

  int id;
  String? name;
  String? categoryName;
  List<Image>? images;
  List<Lesson>? lessons;
  int likes;

  factory Course.fromJson(Map<String, dynamic> json) => Course(
        id: json["id"],
        name: json["name_of_course"],
        categoryName: json["category"],
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        lessons:
            List<Lesson>.from(json["lessons"].map((x) => Lesson.fromJson(x))),
        likes: json["likes"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name_of_course": name,
        "category": categoryName,
        "images": List<Image>.from(images!.map((x) => x.toJson())),
        "lessons": List<Lesson>.from(lessons!.map((x) => x.toJson())),
        "likes": likes,
      };
}

class Image {
  Image({
    this.image,
  });

  String? image;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
      };
}

class Lesson {
  Lesson({
    this.id,
    this.name,
    this.description,
    this.course,
    this.videos,
  });

  int? id;
  String? name;
  String? description;
  int? course;
  List<Video>? videos;

  factory Lesson.fromJson(Map<String, dynamic> json) => Lesson(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        course: json["course"],
        videos: List<Video>.from(json["videos"].map((x) => Video.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "course": course,
        "videos": List<Video>.from(videos!.map((x) => x)),
      };
}

class SavedList {
  SavedList({
    this.id,
    this.saved,
    this.user,
    this.course,
  });

  int? id;
  bool? saved;
  String? user;
  Course? course;

  factory SavedList.fromJson(Map<String, dynamic> json) => SavedList(
        id: json["id"],
        saved: json["saved"],
        user: json["user"],
        course: Course.fromJson(json["course"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "saved": saved,
        "user": user,
        "course": course?.toJson(),
      };
}

class Video {
  Video({
    required this.url,
  });

  final String url;

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        url: json["video"],
      );

  Map<String, dynamic> toJson() => {
        "video": url,
      };
}
