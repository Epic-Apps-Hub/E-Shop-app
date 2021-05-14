import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/blocs/bloc/auth/auth_bloc.dart';
import 'package:shop_app/views/orders/ordersScreen.dart';

class AccountScreen extends StatefulWidget {
  final String email;
  final String name;

  const AccountScreen(this.email, this.name);
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 16, right: 16, top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Hi, ${widget.name}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 22,
                                  color: Colors.black),
                              //    style: AppTextStyles.medium22Black,
                            ),
                            Text(
                              widget.email,
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xff81819A),
                              ),
                              //  style: AppTextStyles.normal14Color4C4C6F,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Edit",
                          style: TextStyle(color: Colors.green, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("My Orders"),
                    leading: Icon(Icons.shopping_basket),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (ctx)=>OrdersScreen()));
                      //     Navigator.of(context).pushNamed(Routes.myOrdersScreen);
                    },
                  ),
                  ListTile(
                    title: Text("MyAddress"),
                    leading: Icon(Icons.place),
                    onTap: () {
                      //    Navigator.of(context).pushNamed(Routes.myAddressScreen);
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text("LogOut"),
                    leading: Icon(Icons.exit_to_app),
                    onTap: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.remove("jwt");
                      BlocProvider.of<AuthBloc>(context)
                          .add(CheckAuth(prefs.getString("jwt")));
                      /*   AppInjector.get<AuthRepository>()
                          .logoutUser()
                          .then((value) {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            Routes.loginScreen, (route) => false);*/
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
