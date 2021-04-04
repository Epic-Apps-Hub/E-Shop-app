import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/repos/products/productsRepo.dart';
part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductsRepo productsRepo;
  ProductsBloc(this.productsRepo) : super(ProductsInitial());

  @override
  Stream<ProductsState> mapEventToState(
    ProductsEvent event,
  ) async* {
    if (event is FetchProducts) {
      yield ProductsLoading();
      List prods = await productsRepo.getProductsByCategory(event.categoryId);
      if (prods == null) {
        yield ProductsError('an error occured');
      }
      yield ProductsLoaded(prods);
    }
  }
}
