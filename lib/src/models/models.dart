// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int? count;
  String? next;
  dynamic? previous;
  List<Course>? results;

  Welcome copyWith({
    int? count,
    String? next,
    dynamic? previous,
    List<Course>? results,
  }) =>
      Welcome(
        count: count ?? this.count,
        next: next ?? this.next,
        previous: previous ?? this.previous,
        results: results ?? this.results,
      );

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        count: json["count"] == null ? null : json["count"],
        next: json["next"] == null ? null : json["next"],
        previous: json["previous"],
        results: json["results"] == null
            ? null
            : List<Course>.from(json["results"].map((x) => Course.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count == null ? null : count,
        "next": next == null ? null : next,
        "previous": previous,
        "results": results == null
            ? null
            : List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class Course {
  Course({
    this.id,
    this.nameOfCourse,
    this.category,
    this.lessons,
  });

  int? id;
  String? nameOfCourse;
  String? category;
  List<Lesson>? lessons;

  Course copyWith({
    int? id,
    String? nameOfCourse,
    String? category,
    List<Lesson>? lessons,
  }) =>
      Course(
        id: id ?? this.id,
        nameOfCourse: nameOfCourse ?? this.nameOfCourse,
        category: category ?? this.category,
        lessons: lessons ?? this.lessons,
      );

  factory Course.fromJson(Map<String, dynamic> json) {
    print("Course :$json");
    return Course(
      id: json["id"] == null ? null : json["id"],
      nameOfCourse:
          json["name_of_course"] == null ? null : json["name_of_course"],
      category: json["category"] == null ? null : json["category"],
      lessons: json["lessons"] == null
          ? null
          : List<Lesson>.from(json["lessons"].map((x) => Lesson.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name_of_course": nameOfCourse == null ? null : nameOfCourse,
        "category": category == null ? null : category,
        "lessons": lessons == null
            ? null
            : List<dynamic>.from(lessons!.map((x) => x.toJson())),
      };
}

class Lesson {
  Lesson({
    this.id,
    this.name,
    this.description,
    this.course,
  });

  int? id;
  String? name;
  String? description;
  int? course;

  Lesson copyWith({
    int? id,
    String? name,
    String? description,
    int? course,
  }) =>
      Lesson(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        course: course ?? this.course,
      );

  factory Lesson.fromJson(Map<String, dynamic> json) {
    print("json :$json");
    return Lesson(
      id: json["id"] == null ? null : json["id"],
      name: json["name"] == null ? null : json["name"],
      description: json["description"] == null ? null : json["description"],
      course: json["course"] == null ? null : json["course"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "description": description == null ? null : description,
        "course": course == null ? null : course,
      };
}
