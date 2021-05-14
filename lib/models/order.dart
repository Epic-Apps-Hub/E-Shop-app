import 'package:hive/hive.dart';
part 'order.g.dart';

@HiveType(typeId: 2)
class OfflineOrder extends HiveObject {
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

  @HiveField(6)
  int count;



  OfflineOrder({this.name, this.price, this.id, this.discount, this.imageUrl,
      this.imageHash,this.count});
}
