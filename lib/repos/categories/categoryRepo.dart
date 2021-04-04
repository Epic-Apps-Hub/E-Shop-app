import 'package:shop_app/constants.dart';
import 'package:dio/dio.dart';
import 'package:shop_app/models/category.dart';

abstract class CategoryRepo {
  Future getCategories();
}

class FetchCategories extends CategoryRepo {
  @override
  Future getCategories() async {
    Response response = await Dio().get("$baseUrl/categories");
    //var categories=Category.fromJson(response.data);
    //
    List<Category> categories = [];
    response.data.forEach((cat) {
      categories.add(Category.fromJson(cat));
    });
//    response.data.map((cat)  {categories.add(Category.fromJson(cat));});
    print(categories);
    return categories;
  }
}
