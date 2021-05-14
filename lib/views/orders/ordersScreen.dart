import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart' as hflut;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shop_app/blocs/bloc/singleProduct/bloc/product_bloc.dart';

import 'package:shop_app/constants.dart';
import 'package:shop_app/models/order.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/repos/favorites/hiveDb.dart';
import 'package:shop_app/repos/products/ProductRepo.dart';
import 'package:shop_app/views/productDetails2.dart';

class OrdersScreen extends StatefulWidget {
  final BuildContext mainPageContext;

  const OrdersScreen({Key key, this.mainPageContext}) : super(key: key);
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  int totalPrice = 0;
  int quantity = 0;
  @override
  void initState() {
    calculateTotal();

    super.initState();
  }

  void calculateTotal() {
    var box = Hive.box("OrdersBox");
    List<OfflineOrder> orders = [];
    for (int i = 0; i < box.length; i++) {
      orders.add(box.getAt(i));
    }
    if (box.length == 0) {
      quantity = 0;
      totalPrice = 0;
    }

    orders.forEach((element) {
      quantity = quantity + element.count;

      totalPrice = totalPrice + element.price * element.count;
    });
  }

  void quantityIncDec(bool isInc) {
    if (isInc) {
      quantity = quantity + 1;
    } else {
      quantity = quantity - 1;
    }
  }

  void priceIncDec(bool isInc, int index) {
    var box = Hive.box("OrdersBox");
    List<OfflineOrder> orders = [];
    for (int i = 0; i < box.length; i++) {
      orders.add(box.getAt(i));
    }
    if (isInc) {
      totalPrice = totalPrice + orders[index].price;
    } else {
      orders.forEach((element) {
        totalPrice = totalPrice - element.price;
      });
    }
  }

  void removeItem(int index) {
    var box = Hive.box("OrdersBox");
    List<OfflineOrder> orders = [];
    for (int i = 0; i < box.length; i++) {
      orders.add(box.getAt(i));
    }
    totalPrice = totalPrice - (orders[index].price * orders[index].count);
    quantity = quantity - orders[index].count;
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Color(0xffF1F1F4),
        appBar: AppBar(
          title: Text(
            "Your Cart",
            style: TextStyle(color: Colors.white),
          ),
          brightness: Brightness.dark,
          backgroundColor: Color(0xff7A1DFF),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: Column(
          children: [
            Container(
              height: _height * .64,
              width: _width,
              child: hflut.WatchBoxBuilder(
                box: Hive.box("OrdersBox"),
                builder: (ctx, box) {
                  if (box.toMap().length == 0) {
                    return Center(
                        child: Text("There is no items in your cart",
                            style: TextStyle(
                                color: mainColor,
                                fontFamily: 'RaleWay',
                                fontSize: 18)));
                  }
                  return ListView.builder(
                      itemBuilder: (ctx, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 30.0, right: 30, top: 30),
                          child: Container(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        showCupertinoModalBottomSheet(
                                            context: context,
                                            isDismissible: false,
                                            enableDrag: false,
                                            bounce: false,
                                            builder: (ctx) {
                                              return Container(
                                                width: _width,
                                                height: _height,
                                                child: BlocProvider(
                                                  create: (context) =>
                                                      ProductBloc(FetchProductById()),
                                                  child: ProductDetails2(
                                                      id: box.getAt(index).id),
                                                ),
                                              );
                                            });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 28.0, top: 25),
                                        child: Image(
                                          image: CachedNetworkImageProvider(
                                              box.getAt(index).imageUrl),
                                          height: 90,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 28.0, top: 25),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            box.getAt(index).name,
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 22,
                                            ),
                                          ),
                                          Text(
                                            '\$ ' +
                                                box
                                                    .getAt(index)
                                                    .price
                                                    .toString(),
                                            style: TextStyle(
                                                color: mainColor,
                                                fontSize: 23,
                                                fontFamily: 'Raleway'),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 28.0, top: 15),
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          if (box.getAt(index).count > 1) {
                                            HiveRepo().updateCount(
                                                index,
                                                Product(
                                                  name: box.getAt(index).name,
                                                  price: box.getAt(index).price,
                                                  id: box.getAt(index).id,
                                                  imageUrl:
                                                      box.getAt(index).imageUrl,
                                                  discount:
                                                      box.getAt(index).discount,
                                                  imageHash: box
                                                      .getAt(index)
                                                      .imageHash,
                                                ),
                                                box.getAt(index).count--);
                                            quantityIncDec(false);
                                            priceIncDec(false, index);
                                            setState(() {});
                                          }
                                        },
                                        child: Container(
                                          height: 30,
                                          width: 30,
                                          child: Center(
                                            child: Icon(
                                              Icons.remove,
                                              color: Colors.grey,
                                              size: 20,
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey,
                                                  width: .4)),
                                        ),
                                      ),
                                      Container(
                                        height: 30,
                                        width: 30,
                                        child: Center(
                                          child: Text(box
                                              .getAt(index)
                                              .count
                                              .toString()),
                                        ),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey, width: .4)),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          HiveRepo().updateCount(
                                              index,
                                              Product(
                                                name: box.getAt(index).name,
                                                price: box.getAt(index).price,
                                                id: box.getAt(index).id,
                                                imageUrl:
                                                    box.getAt(index).imageUrl,
                                                discount:
                                                    box.getAt(index).discount,
                                                imageHash:
                                                    box.getAt(index).imageHash,
                                              ),
                                              (box.getAt(index).count++));
                                          quantityIncDec(true);
                                          priceIncDec(true, index);

                                          setState(() {});
                                        },
                                        child: Container(
                                          height: 30,
                                          width: 30,
                                          child: Center(
                                            child: Icon(
                                              Icons.add,
                                              color: Colors.grey,
                                              size: 20,
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey
                                                      .withOpacity(.8),
                                                  width: .4)),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          removeItem(index);

                                          HiveRepo().deleteOrder(index);

                                          setState(() {});
                                        },
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 18.0, right: 4),
                                              child: Icon(
                                                FontAwesome5.trash,
                                                color:
                                                    Colors.grey.withOpacity(.8),
                                                size: 16,
                                              ),
                                            ),
                                            Text(
                                              "Remove",
                                              style: TextStyle(
                                                  color: Colors.grey
                                                      .withOpacity(.8)),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            height: _height * .22,
                            width: _width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        );
                      },
                      itemCount: box.toMap().length);
                },
              ),
            ),
            FadeInDown(
              child: Container(
                height: _height * .25,
                width: _width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Container(
                        height: _height * .15,
                        width: _width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 18.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "Product Quantity",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      letterSpacing: 1,
                                      fontSize: 16,
                                      fontFamily: 'Raleway',
                                    ),
                                  ),
                                  Text(
                                    quantity.toString(),
                                    style: TextStyle(
                                      color: mainColor,
                                      fontSize: 16,
                                      fontFamily: 'Raleway',
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 18.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "Total Price",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      letterSpacing: 1,
                                      fontSize: 16,
                                      fontFamily: 'Raleway',
                                    ),
                                  ),
                                  Text(
                                    "\$ $totalPrice",
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 16,
                                      fontFamily: 'Aileron',
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    FadeInUp(
                      child: Padding(
                        padding: EdgeInsets.only(left: 60, top: 15, right: 60),
                        child: Container(
                          height: _height * .07,
                          decoration: BoxDecoration(
                              color: Color(0xff7A1DFF),
                              borderRadius: BorderRadius.circular(35)),
                          child: Center(
                            child: Text(
                              "Proceed to Checkout",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: 'Aileron'),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
