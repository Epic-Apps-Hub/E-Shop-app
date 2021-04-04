part of 'searchproducts_bloc.dart';

@immutable
abstract class SearchproductsEvent {}


class SearchProducts extends SearchproductsEvent{
  final String searchKeyword;

  SearchProducts(this.searchKeyword);
}