part of 'favorites_bloc.dart';

@immutable
abstract class FavoritesState {}

class FavoritesInitial extends FavoritesState {}


class FavoriteCheckLoaded extends FavoritesState{
  final bool isFav;

  FavoriteCheckLoaded(this.isFav);
  
}

class FavoritesLoaded extends FavoritesState{
  final List<Product> prods;

  FavoritesLoaded(this.prods);
  
}


