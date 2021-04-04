part of 'categories_bloc.dart';

@immutable
abstract class CategoriesState {}

class CategoriesInitial extends CategoriesState {}


class FetchLoading extends CategoriesState{}

class FetchDone extends CategoriesState{
  final List<Category> categories;

  FetchDone(this.categories);
  
}


class FetchError extends CategoriesState{
  final String error;

  FetchError(this.error);
  
}
