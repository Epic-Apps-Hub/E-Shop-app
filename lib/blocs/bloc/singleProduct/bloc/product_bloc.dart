import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/repos/products/ProductRepo.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepo productRepo;
  ProductBloc(this.productRepo) : super(ProductInitial());

  @override
  Stream<ProductState> mapEventToState(
    ProductEvent event,
  ) async* {
    if (event is FetchProduct) {
      yield ProductLoading();
      Product product = await productRepo.getProduct(event.id);
      print('**************************************');
      print(product);
      if(product!=null){
        yield ProductLoaded(product);
      }else{
        yield ErrorHappened('An error occured, sorry');
      }
    }
  }
}
