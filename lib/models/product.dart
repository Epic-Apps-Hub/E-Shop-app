// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  Product({
    this.richDescription,
    this.imageUrl,
    this.images,
    this.brand,
    this.price,
    this.discount,
    this.rating,
    this.numReviews,
    this.isFeatured,
    this.id,
    this.color,
    this.imageHash,
    this.name,
    this.description,
    this.category,
    this.countInStock,
    this.dateCreated,
    this.v,
  });

  String richDescription;
  String imageUrl;
  List<dynamic> images;
  String brand;
  int price;
  String discount;
  int rating;
  int numReviews;
  bool isFeatured;
  String id;
  String color;
  String imageHash;
  String name;
  String description;
  String category;
  int countInStock;
  DateTime dateCreated;
  int v;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        richDescription: json["richDescription"],
        imageUrl: json["imageUrl"],
        images: List<dynamic>.from(json["images"].map((x) => x)),
        brand: json["brand"],
        price: json["price"],
        discount: json["discount"],
        rating: json["rating"],
        numReviews: json["numReviews"],
        isFeatured: json["isFeatured"],
        id: json["_id"],
        color: json["color"],
        imageHash: json["imageHash"],
        name: json["name"],
        description: json["description"],
        category: json["category"],
        countInStock: json["countInStock"],
        dateCreated: DateTime.parse(json["dateCreated"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "richDescription": richDescription,
        "imageUrl": imageUrl,
        "images": List<dynamic>.from(images.map((x) => x)),
        "brand": brand,
        "price": price,
        "discount": discount,
        "rating": rating,
        "numReviews": numReviews,
        "isFeatured": isFeatured,
        "_id": id,
        "color": color,
        "imageHash": imageHash,
        "name": name,
        "description": description,
        "category": category,
        "countInStock": countInStock,
        "dateCreated": dateCreated.toIso8601String(),
        "__v": v,
      };
//name,price,discount,imageUrl,referId,imageHash
  Map<String, Object> toMap() => {
        "richDescription": richDescription,
        "imageUrl": imageUrl,
        "price": price,
        "discount": discount,
        "referId": id,
        "imageHash": imageHash,
        "name": name,
      };

  static fromMap(Map<String, Object> first) => new Product(
        richDescription: first["richDescription"],
        imageUrl: first["imageUrl"],
        price: first["price"],
        discount: first["discount"],
        id: first["referId"],
        imageHash: first["imageHash"],
        name: first["name"],
      );
}
