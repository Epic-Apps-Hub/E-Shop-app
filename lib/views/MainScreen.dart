import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/iconic_icons.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shop_app/blocs/bloc/Category/categories_bloc.dart';
import 'package:shop_app/blocs/bloc/auth/auth_bloc.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/repos/auth/authRepo.dart';
import 'package:shop_app/repos/categories/categoryRepo.dart';
import 'package:shop_app/views/FavoriteScreen.dart';
import 'package:shop_app/views/HomeScreen.dart';
import 'package:shop_app/views/auth/profile.dart';
import 'package:shop_app/views/endDrawer/endDrawer.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> _buildScreens() {
    return [
      BlocProvider(
        create: (context) => CategoriesBloc(categoryRepo: FetchCategories()),
        child: HomeScreen(mainPageContext: context, scaffoldKey: scaffoldKey),
      ),
      FavScreen(
        mainPageCtx: context,
        scaffoldKey: scaffoldKey,
      ),
      //Container(),
      BlocProvider(
        create: (context) => AuthBloc(Authenticate()),
        child: UnAuthed(mainPageCtx: context),
      ),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.home),
        title: ("Home"),
        activeColorPrimary: Colors.white.withOpacity(.9),
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Iconic.heart_empty),
        title: ("Settings"),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
  /* PersistentBottomNavBarItem(
        icon: Icon(Icons.apps),
        title: ("Settings"),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),*/
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person_outline),
        title: ("Settings"),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);
  @override
  void initState() {
    super.initState();
  }

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer:
          EndDrawer(scaffoldKey: scaffoldKey, tabController: _controller,mainPageContext: context),
      key: scaffoldKey,
      body: FadeInUp (
              child: PersistentTabView(
          context,
          controller: _controller,
          screens: _buildScreens(),
          items: _navBarsItems(),
          confineInSafeArea: true,
          backgroundColor: mainColor, // Default is Colors.white.
          handleAndroidBackButtonPress: true, // Default is true.
          resizeToAvoidBottomInset:
              true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
          stateManagement: true, // Default is true.
          hideNavigationBarWhenKeyboardShows:
              true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
          decoration: NavBarDecoration(
            //    borderRadius: BorderRadius.circular(10.0),
            colorBehindNavBar: Colors.white,
          ),
          popAllScreensOnTapOfSelectedTab: true,
          popActionScreens: PopActionScreensType.all,
          itemAnimationProperties: ItemAnimationProperties(
            // Navigation Bar's items animation properties.
            duration: Duration(milliseconds: 200),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: ScreenTransitionAnimation(
            // Screen transition animation on change of selected tab.
            animateTabTransition: true,
            curve: Curves.ease,
            duration: Duration(milliseconds: 200),
          ),
          navBarHeight: 66,
          navBarStyle:
              NavBarStyle.style12, // Choose the nav bar style with this property.
        ),
      ),
    ); //3 5 12
  }
}
