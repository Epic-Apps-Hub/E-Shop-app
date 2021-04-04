import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/repos/products/searchProductsRepo.dart';

part 'searchproducts_event.dart';
part 'searchproducts_state.dart';

class SearchproductsBloc extends Bloc<SearchproductsEvent, SearchproductsState> {
 final SearchRepo searchRepo;
  SearchproductsBloc(this.searchRepo) : super(SearchproductsInitial());

  @override
  Stream<SearchproductsState> mapEventToState(
    SearchproductsEvent event,
  ) async* {
   if(event is SearchProducts){
     yield SearchLoading();
    var products = await searchRepo.getProductsByKeyword(event.searchKeyword);
    if(products==Null){
      yield SearchFailed('an error occured');
    }
    yield SearchLoaded(products);
   }
  }
}
