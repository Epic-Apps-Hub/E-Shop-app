import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/views/orders/ordersScreen.dart';

class EndDrawer extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final mainPageContext;
  final PersistentTabController tabController;
  const EndDrawer(
      {Key key, this.scaffoldKey, this.tabController, this.mainPageContext})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return Container(
      width: _width * .83,
      color: mainColor,
      height: _height,
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: _height * .1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 48.0),
                child: Text(
                  "Menu",
                  style: TextStyle(
                      color: Colors.white, fontSize: 28, fontFamily: 'Raleway'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 48.0),
                child: IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: () {
                      scaffoldKey.currentState.openDrawer();
                    }),
              )
            ],
          ),
          SizedBox(
            height: _height * .175 - 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  scaffoldKey.currentState.openDrawer();
                  tabController.jumpToTab(2);
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 48.0, right: 40, bottom: 15, top: 15),
                  child: Text(
                    "Your account",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontFamily: 'Raleway'),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: _height * .07 - 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => OrdersScreen(
                                mainPageContext: mainPageContext,
                              )));
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 48.0, right: 40, bottom: 15, top: 15),
                  child: Text(
                    "Your cart",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontFamily: 'Raleway'),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: _height * .07 - 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Flushbar(
                    backgroundColor: Colors.white,
                    duration: Duration(seconds: 2),
                    messageText: Text(
                      'Under Development',
                      style: TextStyle(color: mainColor),
                    ),
                  )..show(context);
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 48.0, right: 40, bottom: 15, top: 15),
                  child: Text(
                    "Language",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontFamily: 'Raleway'),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: _height * .07 - 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Flushbar(
                    backgroundColor: Colors.white,
                    duration: Duration(seconds: 2),
                    messageText: Text(
                      'Under Development',
                      style: TextStyle(color: mainColor),
                    ),
                  )..show(context);
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 48.0, right: 40, bottom: 15, top: 15),
                  child: Text(
                    "Dark Mode",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontFamily: 'Raleway'),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: _height * .25 - 15,
          ),
          Text(
            "E-Shop app",
            style: TextStyle(color: Colors.white),
          )
        ],
      )),
    );
  }
}
