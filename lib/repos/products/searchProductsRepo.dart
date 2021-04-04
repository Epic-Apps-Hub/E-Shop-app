import 'package:dio/dio.dart';
import 'package:shop_app/models/product.dart';

import '../../constants.dart';

abstract class SearchRepo{
  getProductsByKeyword(String keyword);
}


class ProductSearch extends SearchRepo{
  @override
  getProductsByKeyword(String keyword)async {
     try {
      List<Product> products = [];
  
      Response res = await Dio().get("$baseUrl/products/search/$keyword");
      if (res.statusCode == 200) {
        res.data.forEach((prod) {
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