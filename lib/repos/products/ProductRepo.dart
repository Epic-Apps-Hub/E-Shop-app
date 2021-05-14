import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/product.dart';

abstract class ProductRepo {
  getProduct(String id);
}

class FetchProductById extends ProductRepo {
  @override
  getProduct(String id) async {
    Product product=Product();
    try {
      Response res = await Dio().get("$baseUrl/products/$id");
       product = Product.fromJson(res.data['data']);
      return product;
    } catch (e) {
      print(e);
    }
  }
}
