import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading/indicator/ball_scale_indicator.dart';
import 'package:loading/loading.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:octo_image/octo_image.dart';
import 'package:shop_app/blocs/bloc/Search%20products/searchproducts_bloc.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/views/errorPage.dart';
import 'package:shop_app/views/productDetails.dart';

class SearchPage extends StatefulWidget {
  final BuildContext mainPageCtx;

  const SearchPage({Key key, this.mainPageCtx}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        brightness: Brightness.dark,
        title: TextField(
          controller: textEditingController,
          autofocus: true,
          style: TextStyle(color: Colors.white),
          keyboardType: TextInputType.text,
          onSubmitted: (value) {
            if (value != null || value.length != 0) {
              BlocProvider.of<SearchproductsBloc>(context)
                  .add(SearchProducts(value));
            }
          },
          decoration: InputDecoration(
              hintText: "Search Products...",
              hintStyle: TextStyle(
                color: Colors.white.withOpacity(.6),
              )),
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
          height: _height,
          width: _width,
          child: BlocBuilder<SearchproductsBloc, SearchproductsState>(
              builder: (ctx, state) {
            if (state is SearchproductsInitial) {
              return Center(
                child: Spin(
                  child: Container(
                    height: MediaQuery.of(context).size.height * .6,
                    child: Center(
                      child: Image(
                        color: mainColor,
                        image: AssetImage(
                          "assets/search.png",
                        ),
                        height: 80,
                      ),
                    ),
                  ),
                ),
              );
            } else if (state is SearchLoading) {
              return Center(
                child: Loading(
                  color: mainColor,
                  indicator: BallScaleIndicator(),
                  size: 120,
                ),
              );
            } else if (state is SearchLoaded) {
              if (state.prods.length != 0) {
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
                                  child: ProductDetails(
                                    product: state.prods[index],
                                  ),
                                );
                              });
                          /*   pushNewScreen(context,
                            withNavBar: false,
                            screen: ProductDetails(
                              product: state.prods[index],
                            ));*/
                          /*   Navigator.push(widget.mainPageCtx, MaterialPageRoute(builder: (ctx)=>ProductDetails(
                              product: state.prods[index],
                            )));*/
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            width: _width * .12,
                                            height: _height * .03,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: Colors.black
                                                    .withOpacity(.6)),
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
                                              OctoPlaceholder.blurHash(state
                                                  .prods[index].imageHash)),
                                    )),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12.0, top: 8),
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
                                    padding: const EdgeInsets.only(
                                        right: 12.0, top: 8),
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
              } else {
                return Error2Screen();
              }
            }
            return Container();
          })),
    );
  }
}
/* Text(
                                      "Search Products...",
                                      style: TextStyle(
                                        color: mainColor.withOpacity(.4),
                                      )*/
