part of 'product_bloc.dart';

@immutable
abstract class ProductState {}

class ProductInitial extends ProductState {}


class ProductLoading extends ProductState{}

class ProductLoaded extends ProductState{
  final Product product;

  ProductLoaded(this.product);
}

class ErrorHappened extends ProductState{
  final String message;

  ErrorHappened(this.message);
}