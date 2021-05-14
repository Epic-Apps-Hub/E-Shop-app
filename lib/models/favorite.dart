import 'package:hive/hive.dart';
part 'favorite.g.dart';

@HiveType(typeId: 0)
class Favorite extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  int price;

  @HiveField(2)
  String id;

  @HiveField(3)
  String discount;

  @HiveField(4)
  String imageUrl;

  @HiveField(5)
  String imageHash;

factory Favorite.fromJson(Map<String, dynamic> json) => Favorite(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        discount: json["discount"],
        imageUrl: json["imageUrl"],
        imageHash: json["imageHash"],
    );


  Favorite({this.name, this.price, this.id, this.discount, this.imageUrl,
      this.imageHash});
}
