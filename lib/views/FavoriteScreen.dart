import 'package:cached_network_image/cached_network_image.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:octo_image/octo_image.dart';
import 'package:shop_app/blocs/bloc/favs/bloc/favorites_bloc.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/repos/faborites/db.dart';
import 'package:shop_app/views/productDetails.dart';

import '../constants.dart';

class FavScreen extends StatefulWidget {
  final BuildContext mainPageCtx;

  const FavScreen({Key key, this.mainPageCtx}) : super(key: key);
  @override
  _FavScreenState createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  @override
  void initState() {
    BlocProvider.of<FavoritesBloc>(context).add(GetFavs());
    super.initState();
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
                "Shop App.",
                style: TextStyle(color: mainColor),
              ),
            ],
          ),
        ),
        actions: [
          DelayedDisplay(
            child: InkWell(
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
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
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
    );
  }
}
