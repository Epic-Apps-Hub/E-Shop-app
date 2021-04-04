import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/repos/faborites/db.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc() : super(FavoritesInitial());

  @override
  Stream<FavoritesState> mapEventToState(
    FavoritesEvent event,
  ) async* {
    if (event is GetFavs) {
      yield FavoritesInitial();
      var favs = await DBProvider.db.getAllClients();
      if (favs == null) {
        print('favs == nulk');
      }
      yield FavoritesLoaded(favs);
    } else if (event is ChackFav) {
      bool isFav;
      var prod =  DBProvider.db.getClient(event.referId);
      if (prod == null) {
        isFav = false;
      } else {
        isFav = true;
      }
      yield FavoriteCheckLoaded(isFav);
    } else if (event is AddFav) {
      await DBProvider.db.newClient(event.product);
    } else if (event is DeleteFav) {
      await DBProvider.db.deleteClient(event.product.id);
    }
  }
}
