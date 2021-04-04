part of 'products_bloc.dart';

@immutable
abstract class ProductsState {}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsLoaded extends ProductsState {
  final List<Product> prods;

  ProductsLoaded(this.prods);
}

class ProductsError extends ProductsState {
  final String message;

  ProductsError(this.message);
}
