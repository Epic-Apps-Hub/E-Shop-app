import 'package:dio/dio.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/product.dart';

abstract class ProductsRepo {
  getProductsByCategory(String id);
}

class FetchProductsByCategory extends ProductsRepo {
  @override
  getProductsByCategory(String id) async {
    try {
      List<Product> products = [];
      var categoryId = id;
      Response res = await Dio().get("$baseUrl/products/?category=$categoryId");
      if (res.statusCode == 200) {
        res.data['data'].forEach((prod) {
          products.add(Product.fromJson(prod));
        });
      } else {
        print('an error occured');
      }
      return products;
    } catch (e) {
      print(e);
    }
  }
}
