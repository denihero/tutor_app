import 'package:equatable/equatable.dart';

class Categories extends Equatable {
  final Map<String, String> categories;

  factory Categories.fromJson(List<dynamic> json) {
    Map<String, String> x = {};
    var c = json.forEach((element) {
      x[element["name"]] = element["slug"];
    });
    return Categories(x);
  }
  Categories(this.categories);

  @override
  // TODO: implement props
  List<Object?> get props => [categories];
}
