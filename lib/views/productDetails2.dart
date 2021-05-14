import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:hive/hive.dart';
import 'package:loading/indicator/ball_scale_indicator.dart';
import 'package:loading/loading.dart';
import 'package:shop_app/blocs/bloc/singleProduct/bloc/product_bloc.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/order.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:shop_app/repos/favorites/hiveDb.dart';
import 'package:hive_flutter/hive_flutter.dart' as hflut;
import 'package:shop_app/views/orders/ordersScreen.dart';

class ProductDetails2 extends StatefulWidget {
  final String id;

  const ProductDetails2({Key key, this.id}) : super(key: key);

  @override
  _ProductDetails2State createState() => _ProductDetails2State();
}

class _ProductDetails2State extends State<ProductDetails2> {
  @override
  void initState() {
    print(widget.id);
    BlocProvider.of<ProductBloc>(context).add(FetchProduct(widget.id));
    super.initState();
  }

  //    final bloc = FavoritesBloc();
  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
          child: Material(
        child: BlocBuilder<ProductBloc, ProductState>(builder: (ctx, state) {
          if (state is ProductLoading) {
            return Container(
              height: _height,
              width: _width,
              child: Center(
                child: Loading(
                  color: mainColor,
                  indicator: BallScaleIndicator(),
                ),
              ),
            );
          } else if (state is ProductLoaded) {
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
                                  constraints: new BoxConstraints.loose(
                                      new Size(_width, 300.0)),
                                  child: Swiper(
                                    layout: SwiperLayout.DEFAULT,
                                    itemWidth: _width,
                                    itemHeight: 280,
                                    itemCount: state.product.images.length,
                                    autoplay: false,
                                    itemBuilder: (ctx, ind) {
                                      return Padding(
                                        padding: const EdgeInsets.all(0),
                                        child: ClipRRect(
                                          //  borderRadius: BorderRadius.circular(12),
                                          child: CachedNetworkImage(
                                            imageUrl: state.product.images[ind],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      );
                                    },
                                    pagination: new SwiperPagination(
                                        margin: new EdgeInsets.symmetric(
                                            vertical: 60.0)),
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
                                      backgroundColor:
                                          Colors.white.withOpacity(.3),
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
                                          favs.contains(state.product.id);

                                      int indexOfFav =
                                          favs.indexOf(state.product.id);

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
                                                      HiveRepo()
                                                          .deleteFav(indexOfFav);
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
                                                      HiveRepo()
                                                          .addFav(state.product);
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        child: Text(
                                          state.product.name,
                                          style: TextStyle(
                                              fontSize: 21,
                                              fontFamily: 'Aileron',
                                              color: mainColor),
                                        ),
                                        padding:
                                            EdgeInsets.only(left: 18, top: 25),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(right: 18, top: 25),
                                        child: Text(
                                          "\$${state.product.price}",
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
                                      state.product.description,
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
                                    child: state.product.countInStock != null
                                        ? Text(
                                            "${state.product.countInStock} in stock",
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
                                        " ${state.product.rating} ",
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                            color: mainColor,
                                            fontSize: 17,
                                            fontFamily: 'Raleway',
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        "(${state.product.numReviews})",
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
                                          state.product.brand,
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
                                      padding:
                                          EdgeInsets.only(left: 18, right: 18),
                                      child: Text(
                                        state.product.richDescription,
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
                                                  for (var i = 0;
                                                      i < box.length;
                                                      i++) {
                                                    OfflineOrder fav =
                                                        box.getAt(i);

                                                    orders.add(fav.id);
                                                  }
                                                  print(orders);

                                                  bool isOrdered = orders
                                                      .contains(state.product.id);

                                                  int indexOfOrder = orders
                                                      .indexOf(state.product.id);

                                                  return Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(horizontal: 0),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        if (isOrdered) {
                                                          HiveRepo().deleteOrder(
                                                              indexOfOrder);
                                                        } else {
                                                          print(
                                                            orders.length
                                                                .toString(),
                                                          );
                                                          HiveRepo()
                                                              .addOfflineOrder(
                                                                  state.product,
                                                                  1);
                                                          //35354E
                                                        }
                                                      },
                                                      child: Container(
                                                        width: _width,
                                                        height: 80,
                                                        decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(25),
                                                          color:
                                                              Color(0xffF4F6FD),
                                                        ),
                                                        child: Center(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
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
                                                                            padding:
                                                                                const EdgeInsets.only(right: 5.0),
                                                                            child:
                                                                                Text(
                                                                              "+",
                                                                              style:
                                                                                  TextStyle(
                                                                                fontSize: 24,
                                                                                fontFamily: 'Raleway',
                                                                                color: Color(0xff35354E),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                              'Add to Cart',
                                                                              style: TextStyle(
                                                                                  color: Color(0xff35354E),
                                                                                  fontSize: 19,
                                                                                  letterSpacing: .2,
                                                                                  fontFamily: 'Raleway')),
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
                                                onTap: (){
                                                     Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (ctx) =>
                                                        OrdersScreen()));
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
                                                          BorderRadius.circular(
                                                              23)),
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
          } else if (state is ErrorHappened) {
            return Container(
              height: _height,
              width: _width,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.message,
                      style: TextStyle(color: mainColor, fontSize: 18),
                    ),
                    IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        onPressed: () {
                          Navigator.pop(context);
                        })
                  ],
                ),
              ),
            );
          }
          return Container();
        }),
      ),
    );
  }
}
