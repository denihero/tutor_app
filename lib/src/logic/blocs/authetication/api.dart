import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import '../../../models/category.dart';
import '../../../models/models.dart';
import '../../constant/api.dart';

Future<String> login(String username, String password) async {
  try {
    var response = await http.post(
      Uri.parse("${Api.tutorApi}/account/login/"),
      body: {
        "email": username,
        "password": password,
      },
    );


  if (response.statusCode >= 400) throw UnimplementedError();
  print(response.body.toString());
  if (response.statusCode == 201 || response.statusCode == 200) {
    return jsonDecode(response.body.toString())["token"];
  }
  }catch(e){
    print(e);
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
  var response = await dio.post("${Api.tutorApi}/account/info_users/", data: formData);
  if (response.statusCode! >= 400) {
    throw UnimplementedError();
  }
}

Future<bool> register(String username,String password) async {
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

Future<Map<String, String>> get_categories(String token) async {
  var response = await http
      .get(Uri.parse("${Api.tutorApi}/category/category-list/"), headers: {
    "Authorization": "Token ed9cd3535c97526192f1193639088ad3e06097fe",
  });
  if (response.statusCode >= 400) {
    throw UnimplementedError();
  }
  return Categories.fromJson(
    jsonDecode(utf8.decode(response.bodyBytes)),
  ).categories;
}

get_survey_via_id(int id, String token) async {
  var response =
  await http.get(Uri.parse("${Api.tutorApi}/course/$id/"), headers: {
    "Authorization": "Token $token",
  });
  print(response.body);
  return Course.fromJson(
    jsonDecode(
      response.body.toString(),
    ),
  );
}


/*Stream<Surveys> get_surveys_via_category_stream_fixed(
    String token, String category) async* {
  var response = await http
      .get(Uri.parse("${Api.surveyApi}/surveys/?category=$category"), headers: {
    "Authorization": "Token $token",
  });

  if (jsonDecode(response.body.toString())["count"] == 0) throw Empty();

  if (response.statusCode >= 400) {
    throw UnimplementedError();
  }

  String? next_one;

  try {
    final first_one = jsonDecode(utf8.decode(response.bodyBytes));
    print(first_one);
    next_one = first_one["next"];
    yield Surveys.fromJson(first_one["results"][0]);
  } catch (_) {
    throw UnimplementedError();
  }
  while (next_one != null) {
    var response = await http.get(Uri.parse(next_one), headers: {
      "Authorization": "Token $token",
    });
    final survey = jsonDecode(utf8.decode(response.bodyBytes));
    next_one = survey["next"];
    yield Surveys.fromJson(survey["results"][0]);
  }
  yield Surveys(id: -100);
}
*/
/*
Stream<Surveys> get_surveys_Mine(String token, String email) async* {
  var response = await http
      .get(Uri.parse("${Api.surveyApi}/surveys/?search=$email"), headers: {
    "Authorization": "Token $token",
  });

  if (jsonDecode(response.body.toString())["count"] == 0) throw Empty();

  if (response.statusCode >= 400) {
    throw UnimplementedError();
  }

  String? next_one;

  try {
    final first_one = jsonDecode(utf8.decode(response.bodyBytes));
    print(first_one);
    next_one = first_one["next"];
    yield Surveys.fromJson(first_one["results"][0]);
  } catch (_) {
    throw UnimplementedError();
  }
  while (next_one != null) {
    var response = await http.get(Uri.parse(next_one), headers: {
      "Authorization": "Token $token",
    });
    final survey = jsonDecode(utf8.decode(response.bodyBytes));
    next_one = survey["next"];
    yield Surveys.fromJson(survey["results"][0]);
  }
  yield Surveys(id: -100);
}
// */
// Stream<Surveys> find_surveys_stream_fixed(String title, String token) async* {
//   var response = await http
//       .get(Uri.parse("${Api.surveyApi}/surveys/?search=$title"), headers: {
//     "Authorization": "Token $token",
//   });
//   print(response.body);
//
//   if (jsonDecode(response.body.toString())["count"] == 0) throw Empty();
//
//   if (response.statusCode >= 400) {
//     throw UnimplementedError();
//   }
//
//   String? next_one;
//
//   try {
//     final first_one = jsonDecode(utf8.decode(response.bodyBytes));
//     print(first_one);
//     next_one = first_one["next"];
//     yield Surveys.fromJson(first_one["results"][0]);
//   } catch (_) {
//     throw UnimplementedError();
//   }
//   while (next_one != null) {
//     var response = await http.get(Uri.parse(next_one), headers: {
//       "Authorization": "Token $token",
//     });
//     final survey = jsonDecode(utf8.decode(response.bodyBytes));
//     next_one = survey["next"];
//     yield Surveys.fromJson(survey["results"][0]);
//   }
//   yield Surveys(id: -100);
// }

//not correct function

class Empty {}
/*
//correct one
Stream<Surveys> get_surveys_stream_fixed(String token) async* {
  var response =
  await http.get(Uri.parse("${Api.surveyApi}/surveys/"), headers: {
    "Authorization": "Token $token",
  });
  print(response.body);

  if (jsonDecode(response.body.toString())["count"] == 0) throw Empty();

  if (response.statusCode >= 400) {
    throw UnimplementedError();
  }

  String? next_one;

  try {
    final first_one = jsonDecode(utf8.decode(response.bodyBytes));
    print(first_one);
    next_one = first_one["next"];
    yield Surveys.fromJson(first_one["results"][0]);
  } catch (_) {
    throw UnimplementedError();
  }
  while (next_one != null) {
    var response = await http.get(Uri.parse(next_one), headers: {
      "Authorization": "Token $token",
    });
    final survey = jsonDecode(utf8.decode(response.bodyBytes));
    next_one = survey["next"];
    yield Surveys.fromJson(survey["results"][0]);
  }
  yield Surveys(id: -100);
}

post_sumbissions(Submission sub, String token) async {
  var response = await http.post(Uri.parse("${Api.surveyApi}/sumbitions/"),
      body: json.encode(sub.toJson()),
      // encoding: "",
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Token $token",
      });
  print(response.body);

  if (response.statusCode >= 400) throw UnimplementedError();
}

delete_survey(Surveys survey, String token) async {
  var response_surveys = await http.delete(
    Uri.parse(
      "${Api.surveyApi}/surveys/${survey.id}/",
    ),
    headers: {
      // "Content-Type": "application/json",
      "Authorization": "Token $token",
    },
  );
  print(response_surveys.body);
  if (response_surveys.statusCode >= 400) throw UnimplementedError();
}

post_like(int survey_index, String token) async {
  var response_surveys = await http.post(
      Uri.parse(
        "${Api.surveyApi}/likes/",
      ),
      headers: {
        // "Content-Type": "application/json",
        "Authorization": "Token $token",
      },
      body: {
        "survey": survey_index.toString(),
      });

  if (response_surveys.statusCode >= 400) throw UnimplementedError();
  return jsonDecode(response_surveys.body)["id"];
}

get_likes(String token, String email) async {
  var response_surveys = await http.get(
    Uri.parse(
      "${Api.surveyApi}/likes/",
    ),
    headers: {
      // "Content-Type": "application/json",
      "Authorization": "Token $token",
    },
  );
  log("Likes:${response_surveys.body}");
  if (response_surveys.statusCode >= 400) throw UnimplementedError();
  try {
    return jsonDecode(response_surveys.body);
  } catch (_) {
    return [];
  }
}

delete_like(int like_index, String token) async {
  var response_surveys = await http.delete(
    Uri.parse(
      "${Api.surveyApi}/likes/$like_index/",
    ),
    headers: {
      // "Content-Type": "application/json",
      "Authorization": "Token $token",
    },
  );
  print(response_surveys.body);
  if (response_surveys.statusCode >= 400) throw UnimplementedError();
}

post_survey(Surveys survey, String token, File? image) async {
  try {
    Surveys return_survey;
    return_survey = Surveys.fromJson(await uploadImage(image, survey, token));
    for (Questions i in survey.questions ?? []) {
      Questions question;
      var response_questions = await http.post(
        Uri.parse(
          "${Api.surveyApi}/questions/",
        ),
        headers: {
          // "Content-Type": "application/json",
          "Authorization": "Token $token",
        },
        body: {
          "survey": return_survey.id.toString(),
          "text": i.text,
        },
      );

      if (response_questions.statusCode >= 400) {
        throw UnimplementedError();
      }
      int question_id =
      jsonDecode(utf8.decode(response_questions.bodyBytes))["id"];

      for (Choice c in i.choices ?? []) {
        var response_choices = await http.post(
          Uri.parse("${Api.tutorApi}/choices/"),
          headers: {
            // "Content-Type": "application/json",
            "Authorization": "Token $token",
          },
          body: {
            "text": c.text,
            "question": question_id.toString(),
          },
        );
        if (response_choices.statusCode >= 400) {
          throw UnimplementedError();
        }
        print(response_choices.body);
      }
    }
  } catch (_) {
    throw UnimplementedError();
  }
}

getLastSurvey(String email, String token) async {
  var response = await http.get(
    Uri.parse("${Api.tutorApi}/surveys/?search=$email&ordering=-created_at"),
    headers: {
      "Authorization": "Token $token",
    },
  );
  if (response.statusCode >= 400) return UnimplementedError();
  return Surveys.fromJson(jsonDecode(utf8.decode(response.bodyBytes))["results"][0]);
}
*/

getNameSurname(String email) async {
  var response = await http.get(Uri.parse("${Api.tutorApi}/account/info_users/"));
  print(response.body);
  for (var item in jsonDecode(utf8.decode(response.bodyBytes))) {
    if (item["author"] == email) {
      return [item["name"], item["surname"], item["image"], item["id"]];
    }
  }
}

void main(List<String> args) async {
  // print(await getLastSurvey("ulukbekovbr@gmail.com","8e548b2896b3e1f73315792721575d83be6e800e"));
}

/*Future uploadImage(File? file, Surveys survey, String token) async {
  FormData formData = FormData.fromMap({
    if (file != null) "image": await MultipartFile.fromFile(file.path),
    "title": survey.title,
    "description": survey.description,
    "category": survey.category,
  });
  Dio dio = Dio();
  dio.options.headers['Authorization'] = "Token $token";
  var response = await dio.post("${Api.tutorApi}/surveys/", data: formData);
  if (response.statusCode! >= 400) {
    throw UnimplementedError();
  }
  return response.data;
}
*/
/*get_surveys(int begin) async {
  List<Surveys> surveys = [];
  for (var i = begin; i < begin + 5; i++) {
    var response = await http.get(
      Uri.parse("${Api.surveyApi}/surveys/?page=$i"),
    );
    // print(response.body);
    surveys.add(Surveys.fromJson(
        jsonDecode(utf8.decode(response.bodyBytes))["results"][0]));
  }
  return surveys;
}
*/
