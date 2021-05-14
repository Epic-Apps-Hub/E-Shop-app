import 'package:after_layout/after_layout.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading/indicator/ball_beat_indicator.dart';
import 'package:loading/loading.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:octo_image/octo_image.dart';
import 'package:shop_app/blocs/bloc/Products/products_bloc.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/category.dart';
import 'package:shop_app/views/productDetails.dart';
import '../views/errorPage.dart';

class CategoryProducts extends StatefulWidget {
  final BuildContext mainPageCtx;
  final Category category;

  const CategoryProducts({Key key, this.category, this.mainPageCtx})
      : super(key: key);
  @override
  _CategoryProductsState createState() => _CategoryProductsState();
}

class _CategoryProductsState extends State<CategoryProducts>
    with AfterLayoutMixin {
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          backgroundColor: mainColor,
          title: Text(
            widget.category.name,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Aileron',
            ),
          ),
        ),
        body: BlocBuilder<ProductsBloc, ProductsState>(
          builder: (context, state) {
            if (state is ProductsLoading) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 160,
                  child: Center(
                    child: Loading(
                      indicator: BallBeatIndicator(),
                      color: mainColor,
                    ),
                  ),
                ),
              );
            } else if (state is ProductsLoaded) {
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
                                  product: state.prods[index],mainpageCTX: widget.mainPageCtx,
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
            } else if (state is ProductsError) {
              return Error2Screen();
            }
            return Container();
          },
        ));
  }

/*GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2), itemBuilder: (ctx,index){

      },itemCount: ,)*/
  @override
  void afterFirstLayout(BuildContext context) {
    Future.delayed(Duration(seconds: 1));
    BlocProvider.of<ProductsBloc>(context)
        .add(FetchProducts(widget.category.sId));
  }
}
