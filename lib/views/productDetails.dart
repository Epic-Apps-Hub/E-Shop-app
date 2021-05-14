import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:hive/hive.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/order.dart';
import 'package:shop_app/models/product.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:shop_app/repos/favorites/hiveDb.dart';
import 'package:hive_flutter/hive_flutter.dart' as hflut;
import 'package:shop_app/views/orders/ordersScreen.dart';

class ProductDetails extends StatefulWidget {
  final mainpageCTX;
  final Product product;

  const ProductDetails({Key key, this.product, this.mainpageCTX})
      : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  void dispose() {
    super.dispose();
  }

  //    final bloc = FavoritesBloc();
  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Material(
        child: Container(
          height: _height * .94,
          color: Color(0xffF9FAFE),
          width: _width,
          child: Stack(
            children: [
              FadeInDown(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        ConstrainedBox(
                          constraints:
                              new BoxConstraints.loose(new Size(_width, 300.0)),
                          child: Swiper(
                            layout: SwiperLayout.DEFAULT,
                            itemWidth: _width,
                            itemHeight: 280,
                            itemCount: widget.product.images.length,
                            autoplay: false,
                            itemBuilder: (ctx, ind) {
                              return Padding(
                                padding: const EdgeInsets.all(0),
                                child: ClipRRect(
                                  //  borderRadius: BorderRadius.circular(12),
                                  child: CachedNetworkImage(
                                    imageUrl: widget.product.images[ind],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                            pagination: new SwiperPagination(
                                margin:
                                    new EdgeInsets.symmetric(vertical: 60.0)),
                          ),
                        ),
                        Positioned(
                            top: 20,
                            left: 20,
                            child:
                                /*  IconButton(
                                  color: Colors.white,
                                  icon: Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),*/
                                CircleAvatar(
                              backgroundColor: Colors.white.withOpacity(.3),
                              radius: 24,
                              child: IconButton(
                                color: Colors.white,
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            )),
                        hflut.WatchBoxBuilder(
                            box: Hive.box('myBox'),
                            builder: (ctx, box) {
                              // ignore: deprecated_member_use
                              List<String> favs = new List<String>();
                              for (var i = 0; i < box.length; i++) {
                                var fav = box.getAt(i);

                                favs.add(fav.id);
                              }
                              print(favs);

                              /*      .watch(key: 'id')

                                  .contains(widget.product.id).then((value) => print(value.toString()+"value printed"));*/
                              bool isFavorite =
                                  favs.contains(widget.product.id);

                              int indexOfFav = favs.indexOf(widget.product.id);

                              print(indexOfFav);

                              return Positioned(
                                  top: 20,
                                  right: 20,
                                  child: CircleAvatar(
                                    backgroundColor:
                                        Colors.white.withOpacity(.3),
                                    radius: 25,
                                    child: isFavorite
                                        ? IconButton(
                                            color: Colors.white,
                                            icon: Icon(
                                              Icons.favorite,
                                              color: Colors.white,
                                            ),
                                            onPressed: () {
                                              HiveRepo().deleteFav(indexOfFav);
                                              favs.removeAt(indexOfFav);
                                              setState(() {});
                                            },
                                          )
                                        : IconButton(
                                            color: Colors.white,
                                            icon: Icon(
                                              Icons.favorite_border,
                                              color: Colors.white,
                                            ),
                                            onPressed: () {
                                              HiveRepo().addFav(widget.product);
                                              setState(() {});
                                            },
                                          ),
                                  ));
                            })
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  DelayedDisplay(
                    child: Container(
                      height: _height * .62,
                      width: _width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20))),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                child: Text(
                                  widget.product.name,
                                  style: TextStyle(
                                      fontSize: 21,
                                      fontFamily: 'Aileron',
                                      color: mainColor),
                                ),
                                padding: EdgeInsets.only(left: 18, top: 25),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 18, top: 25),
                                child: Text(
                                  "\$${widget.product.price}",
                                  style: TextStyle(
                                      fontSize: 21,
                                      fontFamily: 'Aileron',
                                      color: mainColor),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Center(
                            child: Text(
                              widget.product.description,
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 17,
                                  fontFamily: 'Raleway',
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: widget.product.countInStock != null
                                ? Text(
                                    "${widget.product.countInStock} in stock",
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 17,
                                        fontFamily: 'Raleway',
                                        fontWeight: FontWeight.w700),
                                  )
                                : Text(
                                    "Out of stock",
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 17,
                                        fontFamily: 'Raleway',
                                        fontWeight: FontWeight.w700),
                                  ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                FontAwesome.star,
                                color: Color(0xffE6BC69),
                              ),
                              Text(
                                " ${widget.product.rating} ",
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                    color: mainColor,
                                    fontSize: 17,
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.w700),
                              ),
                              Text(
                                "(${widget.product.numReviews})",
                                textAlign: TextAlign.justify,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 18),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Brand: ",
                                  style: TextStyle(
                                      color: mainColor,
                                      fontFamily: 'Aileron',
                                      fontSize: 18),
                                ),
                                Text(
                                  widget.product.brand,
                                  style: TextStyle(
                                      color: mainColor,
                                      fontFamily: 'Raleway',
                                      fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: Padding(
                              padding: EdgeInsets.only(left: 18, right: 18),
                              child: Text(
                                widget.product.richDescription,
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15,
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: _height * .07,
                          ),
                          Container(
                            height: _height * .165,
                            width: _width,
                            child: Stack(
                              children: [
                                Positioned(
                                  bottom: 0,
                                  child: DelayedDisplay(
                                    fadeIn: true,
                                    delay: Duration(milliseconds: 800),
                                    child: hflut.WatchBoxBuilder(
                                        box: Hive.box("OrdersBox"),
                                        builder: (ctx, box) {
                                          List<String> orders =
                                              new List<String>();
                                          for (var i = 0; i < box.length; i++) {
                                            OfflineOrder fav = box.getAt(i);

                                            orders.add(fav.id);
                                          }
                                          print(orders);

                                          bool isOrdered = orders
                                              .contains(widget.product.id);

                                          int indexOfOrder =
                                              orders.indexOf(widget.product.id);

                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 0),
                                            child: GestureDetector(
                                              onTap: () {
                                                if (isOrdered) {
                                                  HiveRepo().deleteOrder(
                                                      indexOfOrder);
                                                } else {
                                                  print(
                                                    orders.length.toString(),
                                                  );
                                                  HiveRepo().addOfflineOrder(
                                                      widget.product, 1);
                                                }
                                              },
                                              child: Container(
                                                width: _width,
                                                height: 80,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                  color: Color(0xffF4F6FD),
                                                ),
                                                child: Center(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 28.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        isOrdered
                                                            ? Text(
                                                                'Added to cart',
                                                                style: TextStyle(
                                                                    color: Color(
                                                                        0xff35354E),
                                                                    fontSize:
                                                                        19,
                                                                    letterSpacing:
                                                                        .2,
                                                                    fontFamily:
                                                                        'Raleway'))
                                                            : Row(
                                                                children: [
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            5.0),
                                                                    child: Text(
                                                                      "+",
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            24,
                                                                        fontFamily:
                                                                            'Raleway',
                                                                        color: Color(
                                                                            0xff35354E),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                      'Add to Cart',
                                                                      style: TextStyle(
                                                                          color: Color(
                                                                              0xff35354E),
                                                                          fontSize:
                                                                              19,
                                                                          letterSpacing:
                                                                              .2,
                                                                          fontFamily:
                                                                              'Raleway')),
                                                                ],
                                                              )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                ),
                                Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (ctx) =>
                                                        OrdersScreen(
                                                          mainPageContext:
                                                              widget
                                                                  .mainpageCTX,
                                                        )));
                                          },
                                          child: Container(
                                            height: 80,
                                            width: 80,
                                            child: Icon(
                                              FontAwesome5.shopping_cart,
                                              color: Colors.white,
                                            ),
                                            decoration: BoxDecoration(
                                                color: Color(0xff35354E),
                                                borderRadius:
                                                    BorderRadius.circular(23)),
                                          ),
                                        ),
                                      ],
                                    )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
/*
class Fav extends StatefulWidget {
  final Product product;

  const Fav({Key key, this.product}) : super(key: key);
  @override
  _FavState createState() => _FavState();
}

class _FavState extends State<Fav> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Object>(
        future: DBProvider.db.getClient(widget.product.id),
        builder: (context, snapshot) {
          return Positioned(
              top: 20,
              right: 20,
              child: CircleAvatar(
                backgroundColor: Colors.white.withOpacity(.3),
                radius: 25,
                child: !snapshot.hasData
                    ? IconButton(
                        color: Colors.white,
                        icon: Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                        ),
                        onPressed: () {
                       //   DBProvider.db.newClient(widget.product);
                          setState(() {});
                        },
                      )
                    : IconButton(
                        color: Colors.white,
                        icon: Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                        onPressed: () {
                         // DBProvider.db.deleteClient(widget.product.id);
                          setState(() {});
                        },
                      ),
              ));
        });
  }
}*/
