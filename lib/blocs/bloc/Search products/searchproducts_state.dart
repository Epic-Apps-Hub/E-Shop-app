part of 'searchproducts_bloc.dart';

@immutable
abstract class SearchproductsState {}

class SearchproductsInitial extends SearchproductsState {}


class SearchLoading extends SearchproductsState{

}class SearchLoaded extends SearchproductsState{
  final List<Product> prods;

  SearchLoaded(this.prods);
  
}

class SearchFailed extends SearchproductsState{
  final String mssg;

  SearchFailed(this.mssg);
  
}