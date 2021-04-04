import 'package:after_layout/after_layout.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading/indicator/ball_beat_indicator.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shop_app/blocs/bloc/Search%20products/searchproducts_bloc.dart';
import 'package:shop_app/repos/products/productsRepo.dart';
import 'package:shop_app/repos/products/searchProductsRepo.dart';
import 'package:shop_app/views/searchPage.dart';
import 'package:shop_app/blocs/bloc/Products/products_bloc.dart';
import 'package:loading/loading.dart';
import 'package:octo_image/octo_image.dart';
import 'package:shop_app/blocs/bloc/Category/categories_bloc.dart';
import 'package:shop_app/constants.dart';
import './CategoryProductsPage.dart';

class HomeScreen extends StatefulWidget {
  final BuildContext mainPageContext;

  const HomeScreen({Key key, this.mainPageContext}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AfterLayoutMixin<HomeScreen> {
  TabController controller;

  @override
  void afterFirstLayout(BuildContext context) {
    BlocProvider.of<CategoriesBloc>(context).add(FetchData());
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: mainColor,
        elevation: 0,
        title: Row(
          children: [
            Image(
              image: AssetImage('assets/logo.png'),
              height: 30,
            ),
            Text(
              "Shop App.",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Aileron',
              ),
            ),
          ],
        ),
        actions: [
          InkWell(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Image(
                image: AssetImage('assets/menuIcon.png'),
              ),
            ),
          )
        ],
      ),
      body: Container(
        child: Center(
          child: ListView(
            children: [
              Container(
                height: _height * .15,
                width: _width,
                decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(45),
                        bottomRight: Radius.circular(45))),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 25,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) => BlocProvider(
                                      create: (context) =>
                                          SearchproductsBloc(ProductSearch()),
                                      child: SearchPage(
                                        mainPageCtx: widget.mainPageContext,
                                      ))));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.white),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Icon(
                                      Icons.search,
                                      color: mainColor,
                                    ),
                                  ),
                                  /*   Container(
                                      width: _width * .7,
                                      child: TextField(enabled: false,
                                      enableSuggestions:true,
                                      
                                        decoration: InputDecoration(
                                            labelText: "Search Products...",labelStyle: TextStyle(
                                          color: mainColor.withOpacity(.4),
                                        ),focusColor: mainColor),
                                      ),
                                    ),*/
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: 20, bottom: 20),
                                    child: Text(
                                      "Search Products...",
                                      style: TextStyle(
                                        color: mainColor.withOpacity(.4),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: _width * .4,
                                  )
                                ],
                              )),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              BlocBuilder<CategoriesBloc, CategoriesState>(
                builder: (context, state) {
                  if (state is FetchLoading) {
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
                  } else if (state is FetchDone) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 29.0),
                      child: ListView.builder(
                          itemCount: state.categories.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (ctx, index) {
                            return Builder(
                              builder: (ctx) => InkWell(
                                onTap: () {
                                  pushNewScreen(context,
                                      withNavBar: true,
                                      screen: BlocProvider(
                                        create: (ctx) => ProductsBloc(
                                            FetchProductsByCategory()),
                                        child: CategoryProducts(
                                          category: state.categories[index],
                                          mainPageCtx: widget.mainPageContext,
                                        ),
                                      ));
                                  /*  Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (_) => BlocProvider(
                                                  create: (ctx) => ProductsBloc(
                                                      FetchProductsByCategory()),
                                                  child: CategoryProducts(
                                                    category:
                                                        state.categories[index],
                                                  ),
                                                )));*/
                                },
                                child: Container(
                                  height: _height * .25,
                                  width: _width,
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 28.0),
                                          child: Container(
                                              width: _width,
                                              height: _height * .19,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: OctoImage(
                                                  image:
                                                      CachedNetworkImageProvider(
                                                          state
                                                              .categories[index]
                                                              .icon),
                                                  placeholderBuilder:
                                                      OctoPlaceholder.blurHash(
                                                          state
                                                              .categories[index]
                                                              .imageHash),
                                                  fit: BoxFit.cover,
                                                ),
                                              )),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Center(
                                            child: Text(
                                              state.categories[index].name,
                                              style: TextStyle(
                                                  color: mainColor,
                                                  fontFamily: 'Aileron',
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    );
                  }
                  return Container();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
