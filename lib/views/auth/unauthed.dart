import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/views/auth/login.dart';

class UnAuthed extends StatefulWidget {
  final BuildContext mainPageCtx;

  const UnAuthed({Key key, this.mainPageCtx}) : super(key: key);
  @override
  _UnAuthedState createState() => _UnAuthedState();
}

class _UnAuthedState extends State<UnAuthed> {
  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: _height,
        width: _width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: _height * .06,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Hello..',
                  style: TextStyle(
                      color: mainColor, fontFamily: 'Aileron', fontSize: 34),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'You are Not signed in',
                  style: TextStyle(
                      color: mainColor, fontFamily: 'Raleway', fontSize: 18),
                ),
              ],
            ),
            SizedBox(
              height: _height * .03,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: GestureDetector(
                onTap: (){
                  pushNewScreen(context, screen:  Login3(),withNavBar: false,pageTransitionAnimation: PageTransitionAnimation.slideUp);

                },
                              child: Container(
                  height: _height * .09,
                  width: _width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(45),
                    color: mainColor,
                  ),
                  child: Center(
                    child: Text(
                      "Login/Signup",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Raleway',
                          fontSize: 26),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
