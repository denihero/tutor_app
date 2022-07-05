part of 'categories_cubit.dart';

abstract class Cat extends Equatable {
  
  @override
  List<Object?> get props => [];
}

class Categories extends Cat {
  final Map<String, String> categories;

  Categories(this.categories);
  
  @override
  List<Object?> get props => [categories];
}

class CategoriesLoading extends Cat {}
class CategoriesInitial extends Cat {}
class CategoriesError extends Cat {}
