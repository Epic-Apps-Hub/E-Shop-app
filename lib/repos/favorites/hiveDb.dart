import 'package:hive/hive.dart';
import 'package:shop_app/models/favorite.dart';
import 'package:shop_app/models/order.dart';
import 'package:shop_app/models/product.dart';

class HiveRepo {
  Future<void> addFav(Product product) async {
    var box = Hive.box('myBox');
    var person = Favorite(
        name: product.name,
        price: product.price,
        id: product.id,
        discount: product.discount,
        imageUrl: product.imageUrl,
        imageHash: product.imageHash);

    box.add(person);
  }

  Future<void> deleteFav(int index) async {
    var box = Hive.box('myBox');

    box.deleteAt(index);
  }

  Future<void> deleteAll() async {
    var box = Hive.box('myBox');
    for (int i = 0; i < box.length; i++) {
      box.deleteAt(i);
    }
  }

  ///////order functions
  addOfflineOrder(Product product, int count) {
    var box = Hive.box('OrdersBox');
    var order = OfflineOrder(
        count: count,
        discount: product.discount,
        id: product.id,
        imageHash: product.imageHash,
        price: product.price,
        imageUrl: product.imageUrl,
        name: product.name);
    box.add(order);
  }

  Future<void> deleteOrder(int index) async {
    var box = Hive.box('OrdersBox');

    box.deleteAt(index);
  }

  Future<void> updateCount(int index, Product product, count) async {
    var box = Hive.box('myBox');
    var order = OfflineOrder(
        count: count,
        discount: product.discount,
        id: product.id,
        imageHash: product.imageHash,
        price: product.price,
        imageUrl: product.imageUrl,
        name: product.name);
    box.putAt(index, order);
  }

  Future<void> deleteOrders() async {
    var box = Hive.box('myBox');
    for (int i = 0; i < box.length; i++) {
      box.deleteAt(i);
    }
  }
}
