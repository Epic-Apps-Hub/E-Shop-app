import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/models/category.dart';
import 'package:shop_app/repos/categories/categoryRepo.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final CategoryRepo categoryRepo;
  CategoriesBloc({this.categoryRepo}) : super(CategoriesInitial());

  @override
  Stream<CategoriesState> mapEventToState(
    CategoriesEvent event,
  ) async* {

    if (event is FetchData) {
      yield FetchLoading();
      var data = await categoryRepo.getCategories();
      
      if (data==null) {
        yield FetchError("coudn't get data correctly");
      } else {
        yield FetchDone(data);
      }
    }
  }
}
