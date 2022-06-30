import 'package:equatable/equatable.dart';

class Categories extends Equatable {
  final Map<String, String> categories;

  factory Categories.fromJson(List<dynamic> json) {
    Map<String, String> x = {};
    var c = json.forEach((element) {
      x[element["title"]] = element["title"];
    });
    return Categories(x);
  }
  Categories(this.categories);

  @override
  List<Object?> get props => [categories];
}
