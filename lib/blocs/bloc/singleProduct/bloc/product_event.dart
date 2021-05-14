part of 'product_bloc.dart';

@immutable
abstract class ProductEvent {}


class FetchProduct extends ProductEvent{
  final String id;

  FetchProduct(this.id);
  
}

