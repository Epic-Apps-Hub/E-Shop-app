import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/product.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:shop_app/repos/faborites/db.dart';
import '../blocs/bloc/favs/bloc/favorites_bloc.dart';

class ProductDetails extends StatefulWidget {
  final Product product;

  const ProductDetails({Key key, this.product}) : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  void initState() {
    BlocProvider.of<FavoritesBloc>(context).add(ChackFav(widget.product.id));
    super.initState();
  }

  //    final bloc = FavoritesBloc();
  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Material(
        child: Container(
          height: _height,
          color: Colors.white,
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
                            itemHeight: 300,
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
                                    new EdgeInsets.symmetric(vertical: 40.0)),
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
                        BlocBuilder<FavoritesBloc, FavoritesState>(
                          builder: (context, state) {
                            if (state is FavoritesInitial) {
                              return Positioned(
                                  top: 20,
                                  right: 20,
                                  child: CircleAvatar(
                                    backgroundColor:
                                        Colors.white.withOpacity(.3),
                                    radius: 25,
                                  ));
                            } else if (state is FavoriteCheckLoaded) {
                              return Positioned(
                                  top: 20,
                                  right: 20,
                                  child: CircleAvatar(
                                    backgroundColor:
                                        Colors.white.withOpacity(.3),
                                    radius: 25,
                                    child: state.isFav
                                        ? IconButton(
                                            color: Colors.white,
                                            icon: Icon(
                                              Icons.favorite,
                                              color: Colors.white,
                                            ),
                                            onPressed: () {
                                              BlocProvider.of<FavoritesBloc>(
                                                      context)
                                                  .add(DeleteFav(
                                                      widget.product));
                                            },
                                          )
                                        : IconButton(
                                            color: Colors.white,
                                            icon: Icon(
                                              Icons.favorite_border,
                                              color: Colors.white,
                                            ),
                                            onPressed: () {
                                              BlocProvider.of<FavoritesBloc>(
                                                      context)
                                                  .add(AddFav(widget.product));
                                            },
                                          ),
                                  ));
                            }
                            return Container();
                          },
                        )
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
                      height: _height * .66,
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
                          /*"brand": "apple",
                          "price": 999,
                          "discount": "-5%",
                          "rating": 5,
                          "numReviews": 0,
                          "isFeatured": false,
                          "_id": "60666037a7a56c0015f0de70",
                          "color": "Silver",
                          "imageHash": "LdJ*bdxu},t3ZzxsjZRk^*xZW?Rl",
                          "name": "Iphone 12 pro",
                          "description": "Released 2020, October 23",
                          "category": "605cfec87e0f5e130c41f754",
                          "countInStock": 80,
                          "dateCreated": "2021-04-02T00:07:19.479Z",*/
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
                                    fontSize: 17,
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: _height * .08,
                          ),
                          DelayedDisplay(
                            fadeIn: true,
                            delay: Duration(milliseconds: 800),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 28.0),
                              child: Container(
                                width: _width,
                                height: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: mainColor,
                                ),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.shopping_bag_outlined,
                                          color: Colors.white),
                                      SizedBox(
                                        width: 12,
                                      ),
                                      Text('Add to cart',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              letterSpacing: .2,
                                              fontFamily: 'Raleway'))
                                    ],
                                  ),
                                ),
                              ),
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

  Future checkFavs(Product product) async {}
}

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
                          DBProvider.db.newClient(widget.product);
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
                          DBProvider.db.deleteClient(widget.product.id);
                          setState(() {});
                        },
                      ),
              ));
        });
  }
}
