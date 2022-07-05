import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import '../constant/api.dart';
import '../models/category.dart';
import '../models/models.dart';

Future<String> login(String username, String password) async {
  var response = await http.post(
    Uri.parse("${Api.tutorApi}/account/login/"),
    body: {
      "email": username,
      "password": password,
    },
  );
  if (response.statusCode >= 400) throw UnimplementedError();
  if (response.statusCode == 201 || response.statusCode == 200) {
    return jsonDecode(response.body.toString())["token"];
  }
  return "";
}

sendNameSurname(String name, String surname, String token, File? file) async {
  FormData formData = FormData.fromMap({
    if (file != null) "image": await MultipartFile.fromFile(file.path),
    "name": name,
    "surname": surname,
  });
  Dio dio = Dio();
  dio.options.headers['Authorization'] = "Token $token";
  var response =
      await dio.post("${Api.tutorApi}/account/info_users/", data: formData);
  if (response.statusCode! >= 400) {
    throw UnimplementedError();
  }
}

Future<bool> register(String username, String password) async {
  var response = await http.post(
    Uri.parse("${Api.tutorApi}/account/register/"),
    body: {
      "email": username,
      "password": password,
      "password_confirmation": password,
    },
  );
  if (response.statusCode >= 400) throw UnimplementedError();
  if (response.statusCode == 201 || response.statusCode == 200) {
    return true;
  }
  return false;
}

Future<bool> confirmPassword(String username, String code) async {
  var response = await http.post(
    Uri.parse("${Api.tutorApi}/account/activate/"),
    body: {
      "email": username,
      "code": code,
    },
  );
  if (response.statusCode >= 400) throw UnimplementedError();
  if (response.statusCode == 201 || response.statusCode == 200) {
    return true;
  }
  return false;
}

Future<Map<String, String>> getCategories(String token) async {
  var response = await http
      .get(Uri.parse("${Api.tutorApi}/category/category-list/"), headers: {
    "Authorization": "Token $token",
  });
  if (response.statusCode >= 400) {
    throw UnimplementedError();
  }
  return Categories.fromJson(
    jsonDecode(utf8.decode(response.bodyBytes)),
  ).categories;
}

putImage(File? file, int id, String token, String name, String surname) async {
  FormData formData = FormData.fromMap({
    if (file != null) "image": await MultipartFile.fromFile(file.path),
    "name": name,
    "surname": surname,
  });

  Dio dio = Dio();
  dio.options.headers['Authorization'] = "Token $token";
  dio.options.headers['Content-Type'] = "multipart/form-data";
  var response =
      await dio.put("${Api.tutorApi}/account/info_users/$id/", data: formData);
  return response.data["image"];
}

getNameSurname(String email) async {
  var response =
      await http.get(Uri.parse("${Api.tutorApi}/account/info_users/"));
  for (var item in jsonDecode(utf8.decode(response.bodyBytes))) {
    if (item["author"] == email) {
      return [item["name"], item["surname"], item["image"], item["id"]];
    }
  }
}

Future<List<Course>> getCourse(String token) async {
  var response = await http.get(Uri.parse("${Api.tutorApi}/course/"), headers: {
    "Authorization": "Token $token",
  });
  if (response.statusCode >= 400) throw UnimplementedError("Status code");
  final data = jsonDecode(utf8.decode(response.bodyBytes));
  List<Course> ls = [];
  for (var element in data) {
    ls.add(Course.fromJson(element));
  }
  return ls;
}

Future<List<SavedList>> getSavedCourse(String token) async {
  var response =
      await http.get(Uri.parse("${Api.tutorApi}/course/savedlist/"), headers: {
    "Authorization": "Token $token",
  });

  if (response.statusCode >= 400) throw UnimplementedError('Status code');
  final data = jsonDecode(utf8.decode(response.bodyBytes));
  List<SavedList> sl = [];

  for (var element in data) {
    sl.add(SavedList.fromJson(element));
  }
  return sl;
}

Future<void> saveCourses(String token, int id) async {
  var response =
      await http.post(Uri.parse("${Api.tutorApi}/course/$id/saved/"), headers: {
    "Authorization": "Token $token",
  });
  if (response.statusCode >= 400) throw UnimplementedError('Status code');
  if (response.statusCode == 200) {
    return jsonDecode(response.body.toString());
  }
}

Future<Course> getCourseById(String token, int id) async {
  var response =
      await http.get(Uri.parse('${Api.tutorApi}/course/$id/'), headers: {
    "Authorization": "Token $token",
  });
  final data = jsonDecode(utf8.decode(response.bodyBytes));
  if (response.statusCode >= 400) throw UnimplementedError('Status code');

  return Course.fromJson(data);
}

Future<List<Course>> getViewedCourses(String token) async {
  var response =
      await http.get(Uri.parse('${Api.tutorApi}/course/history/'), headers: {
    "Authorization": "Token $token",
  });
  List<Course> ls = [];
  final data = jsonDecode(utf8.decode(response.bodyBytes));
  if (response.statusCode >= 400) throw UnimplementedError('Status code');

  for (var element in data) {
    ls.add(Course.fromJson(element));
  }
  return ls;
}
