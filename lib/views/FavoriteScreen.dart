import 'package:cached_network_image/cached_network_image.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:octo_image/octo_image.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart' as hflut;
import 'package:shop_app/blocs/bloc/singleProduct/bloc/product_bloc.dart';
import 'package:shop_app/repos/products/ProductRepo.dart';
import 'package:shop_app/views/productDetails2.dart';

import '../constants.dart';

class FavScreen extends StatefulWidget {
  final BuildContext mainPageCtx;
  final GlobalKey<ScaffoldState> scaffoldKey;

  const FavScreen({Key key, this.mainPageCtx, this.scaffoldKey})
      : super(key: key);
  @override
  _FavScreenState createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
//  List<Favorite> favs;
  //var box;
  @override
  void initState() {
    //   box =  Hive.openBox('myBox');

    super.initState();
    //map.forEach((k, v) => list.add(Customer(k, v)));
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          backgroundColor: Colors.white,
          elevation: 0,
          title: DelayedDisplay(
            child: Row(
              children: [
                Image(
                  image: AssetImage('assets/logodark.png'),
                  height: 30,
                  // color: mainColor,
                ),
                Text(
                  "Whishlist",
                  style: TextStyle(color: mainColor),
                ),
              ],
            ),
          ),
          actions: [
            DelayedDisplay(
              child: InkWell(
                onTap: () {
                  widget.scaffoldKey.currentState.openEndDrawer();
                },
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Image(
                    image: AssetImage('assets/menuIcon.png'),
                    color: mainColor,
                  ),
                ),
              ),
            )
          ],
        ),
        body: hflut.WatchBoxBuilder(
          box: Hive.box("myBox"),
          builder: (ctx, box) {
            if (box.toMap().length == 0) {
              return Center(
                  child: Text("You have no Favorite items",
                      style: TextStyle(
                          color: mainColor,
                          fontFamily: 'RaleWay',
                          fontSize: 18)));
            }
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 2 / 3),
                itemBuilder: (ctx, index) {
                  return InkWell(
                    onTap: () {
                      showCupertinoModalBottomSheet(
                          context: widget.mainPageCtx,
                          isDismissible: false,
                          enableDrag: false,
                          bounce: false,
                          builder: (ctx) {
                            return Container(
                              width: _width,
                              height: _height,
                              child: BlocProvider(
                                create: (context) => ProductBloc(FetchProductById()),
                                child: ProductDetails2(
                                  id: box.getAt(index).id,
                                ),
                              ),
                            );
                          });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            width: _width * .4,
                            height: _height * .3,
                            child: GridTile(
                                header: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: _width * .12,
                                        height: _height * .03,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color:
                                                Colors.black.withOpacity(.6)),
                                        child: Center(
                                          child: Text(
                                            box
                                                .getAt(index)
                                                .discount
                                                .toString(),
                                            style: TextStyle(
                                                color: Colors.white
                                                    .withOpacity(.9)),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  child: OctoImage(
                                      fit: BoxFit.cover,
                                      image: CachedNetworkImageProvider(
                                          box.getAt(index).imageUrl),
                                      placeholderBuilder:
                                          OctoPlaceholder.blurHash(
                                              box.getAt(index).imageHash)),
                                )),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 12.0, top: 8),
                                child: Text(
                                  box.getAt(index).name,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 12.0, top: 8),
                                child: Text(
                                  box
                                      .getAt(index)
                                      .price
                                      .toString() //"\$${favs[index].price}"
                                  ,
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(.6),
                                      fontSize: 16,
                                      fontFamily: 'Raleway'),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: box.toMap().length);
          },
        ));

    /* ValueListenableBuilder(
            valueListenable: Hive.box("name"),hf
            builder: (context, snapshot) {
              print(snapshot.data);*/
    /*           if (snapshot.hasData) {

                return 
              } else {
                return Container(
                  height: _height,
                  width: _width,
                  child: Center(
                    child: Text("an error occured"),
                  ),
                );
              }*/

    /*    BlocBuilder<FavoritesBloc, FavoritesState>(
            builder: (context, state) {
              if (state is FavoritesLoaded) {
                return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, childAspectRatio: 2 / 3),
                    itemBuilder: (ctx, index) {
                      return InkWell(
                        onTap: () {
                          showCupertinoModalBottomSheet(
                              context: widget.mainPageCtx,
                              isDismissible: false,
                              enableDrag: false,
                              bounce: false,
                              builder: (ctx) {
                                return Container(
                                  width: _width,
                                  height: _height,
                                  child: BlocProvider(
                                    create: (context) => FavoritesBloc(),
                                    child: ProductDetails(
                                      product: state.prods[index],
                                    ),
                                  ),
                                );
                              });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Container(
                                width: _width * .4,
                                height: _height * .3,
                                child: GridTile(
                                    header: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            width: _width * .12,
                                            height: _height * .03,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color:
                                                    Colors.black.withOpacity(.6)),
                                            child: Center(
                                              child: Text(
                                                state.prods[index].discount,
                                                style: TextStyle(
                                                    color: Colors.white
                                                        .withOpacity(.9)),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(12)),
                                      child: OctoImage(
                                          fit: BoxFit.cover,
                                          image: CachedNetworkImageProvider(
                                              state.prods[index].imageUrl),
                                          placeholderBuilder:
                                              OctoPlaceholder.blurHash(
                                                  state.prods[index].imageHash)),
                                    )),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: 12.0, top: 8),
                                    child: Text(
                                      state.prods[index].name,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontFamily: 'Raleway',
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(right: 12.0, top: 8),
                                    child: Text(
                                      "\$${state.prods[index].price}",
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(.6),
                                          fontSize: 16,
                                          fontFamily: 'Raleway'),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: state.prods.length);
              }
              return Container();
            },
          ),

     */
  }
}
