import 'package:animate_do/animate_do.dart' as anm;
import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';

class Login3 extends StatefulWidget {
  @override
  _Login3State createState() => _Login3State();
}

class _Login3State extends State<Login3> {
  Color isactive = mainColor;
  Color isnot = mainColor.withOpacity(.2);
  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController(initialPage: 0);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    int ind = 0;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
     /*     anm.Bounce(
                      child: Container(   decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/back.jpg'), fit: BoxFit.cover)),),
          ),*/
           anm.Bounce(
                      child: Container(
            decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/back.jpg'), fit: BoxFit.cover)),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: height * .28,
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 40,
                      ),
                      Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  pageController.animateToPage(0,
                                      duration: Duration(milliseconds: 250),
                                      curve: Curves.linear);
                                },
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                      color: isactive,
                                      fontSize: 18,
                                      fontFamily: 'cairo'),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  pageController.animateToPage(1,
                                      duration: Duration(milliseconds: 250),
                                      curve: Curves.linear);
                                },
                                child: Text(
                                  'Register',
                                  style: TextStyle(
                                      color: isnot,
                                      fontSize: 18,
                                      fontFamily: 'cairo'),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                color: isactive,
                                height: 2,
                                width: 55,
                              ),
                              Container(
                                color: isnot,
                                height: 2,
                                width: 55,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    height: 540,
                    width: width,
                    child: PageView(
                      onPageChanged: (index) {
                        setState(() {
                          if (index == 0) {
                            setState(() {
                              isactive = mainColor;
                              isnot = mainColor.withOpacity(.2);
                            });
                          } else {
                            setState(() {
                              isactive = mainColor.withOpacity(.2);
                              isnot = mainColor;
                            });
                          }
                        });
                      },
                      controller: pageController,
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            SizedBox(
                              height: 40,
                            ),
                            textField(
                              hint: 'Enter your E-Mail',
                              label: 'User name',
                              obsecured: false,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            textField(
                              hint: 'Enter your password',
                              label: 'password',
                              obsecured: true,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  'forget password?',
                                  style: TextStyle(color: Colors.pink),
                                ),
                                SizedBox(
                                  width: 40,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 40),
                              child: ButtonTheme(
                                buttonColor: mainColor,
                                height: 60,
                                minWidth: width,
                                child: RaisedButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Login',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 35,
                            ),
                            GestureDetector(
                              onTap: () {
                                pageController.animateToPage(1,
                                    duration: Duration(milliseconds: 250),
                                    curve: Curves.linear);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "Don't have an account? Create",
                                    style: TextStyle(
                                        color: mainColor,
                                        fontFamily: 'bree',
                                        fontWeight: FontWeight.w300),
                                  )
                                ],
                              ),
                            )
                          ],
                        ), /////////////////////
                        Column(
                          children: <Widget>[
                            SizedBox(
                              height: 40,
                            ),
                            textField(
                              hint: 'Enter your name',
                              label: 'User name',
                              obsecured: false,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            textField(
                              hint: 'Enter your E-Mail',
                              label: 'Email Address',
                              obsecured: false,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            textField(
                              hint: 'Enter your Password',
                              label: 'password',
                              obsecured: true,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 40),
                              child: ButtonTheme(
                                buttonColor: mainColor,
                                height: 60,
                                minWidth: width,
                                child: RaisedButton(
                                  onPressed: () {},
                                  child: Text('Register',
                                      style: TextStyle(
                                        color: Colors.white,
                                      )),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 35,
                            ),
                            GestureDetector(
                              onTap: () {
                                pageController.animateToPage(0,
                                    duration: Duration(milliseconds: 250),
                                    curve: Curves.linear);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "Already have an account? Login",
                                    style: TextStyle(
                                        color: mainColor,
                                        fontFamily: 'bree',
                                        fontWeight: FontWeight.w100),
                                  )
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class textField extends StatelessWidget {
  String hint;
  String label;
  bool obsecured;
  textField({this.hint, this.label, this.obsecured});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: TextField(
        obscureText: obsecured,
        style: TextStyle(color: Colors.white, fontSize: 15, fontFamily: 'bree'),
        cursorColor: mainColor,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle:
              TextStyle(color: Colors.white, fontSize: 15, fontFamily: 'bree'),
          //  labelText: label,
          labelStyle: TextStyle(color: Colors.white, fontFamily: 'bree'),
          filled: true,
          fillColor: mainColor.withOpacity(.5),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent)),
          disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent)),
        ),
      ),
    );
  }
}
