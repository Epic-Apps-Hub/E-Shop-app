part of 'favorites_bloc.dart';

@immutable
abstract class FavoritesEvent {}

class ChackFav extends FavoritesEvent {
  final String referId;

  ChackFav(this.referId);
}

class GetFavs extends FavoritesEvent {}

class AddFav extends FavoritesEvent {
  final Product product;

  AddFav(this.product);
}

class DeleteFav extends FavoritesEvent {
  final Product product;

  DeleteFav(this.product);
}
