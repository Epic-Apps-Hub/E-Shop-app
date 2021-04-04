import 'package:circular_clip_route/circular_clip_route.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/views/MainScreen.dart';

class WelcomeScreen extends StatefulWidget {
  
  
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: mainColor,
      body: Container(
        width: _width,
        height: _height,
        child: DelayedDisplay(  delay: Duration(milliseconds: 300),
                  child: Column(
            children: [
              SizedBox(
                height: _height * .26,
              ),
               Center(
                  child: Image(
                    image: AssetImage('assets/logo.png'),
                    height: _height * .2,
                  ),
                ),
              
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  'Shop app.',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Opacity(
                  opacity: .9,
                  child: Text(
                    'All You Need',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: _height * .3,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Builder(
                    builder: (ctx) => DelayedDisplay(
                      delay: Duration(milliseconds: 1300),
                                        child: InkWell(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        hoverColor: Colors.white,
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              CircularClipRoute(
                                  //transitionDuration: Duration(seconds: 1),
                                  curve: Curves.linear,
                                  border: Border.all(
                                      color: Colors.transparent, width: 0),
                                  expandFrom: ctx,
                                  builder: (_) => MainScreen()));
                        },
                        child: Container(
                          height: 60,
                          width: _width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            color: secondColor,
                          ),
                          child: Center(
                              child: Text(
                            "Get Started",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 18),
                          )),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
