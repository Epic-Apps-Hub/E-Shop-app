part of 'products_bloc.dart';

@immutable
abstract class ProductsEvent {}


class FetchProducts extends ProductsEvent{
  final String categoryId;

  FetchProducts(this.categoryId);
}

