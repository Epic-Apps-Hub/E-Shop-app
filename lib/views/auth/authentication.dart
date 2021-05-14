import 'dart:async';

import 'package:animate_do/animate_do.dart' as anm;
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fzregex/fzregex.dart';
import 'package:loading/indicator/ball_beat_indicator.dart';
import 'package:loading/loading.dart';
import 'package:loading_button/loading_button.dart';

import 'package:shop_app/blocs/bloc/auth/auth_bloc.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/repos/auth/authRepo.dart';
import 'package:fzregex/utils/pattern.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String loginEmail,
      loginPassword,
      registerEmail,
      registerPassword,
      registerName = '';
  Color isactive = mainColor;
  Color isnot = mainColor.withOpacity(.2);
  GlobalKey<FormState> loginKey = new GlobalKey();
  GlobalKey<FormState> registerKey = new GlobalKey();
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController(initialPage: 0);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (ctx, state) {
          if (state is AuthLoading) {
            setState(() {
              isLoading = true;
            });
          } else if (state is ErrorHappened) {
            setState(() {
              isLoading = false;
            });
            print('flush +${state.message}');
            Flushbar(
              //backgroundColor: Colors.white,
              title: "Error..",
              message: state.message,
              duration: Duration(seconds: 3),
            )..show(context);
          } else if (state is LogedIn) {
            setState(() {
              isLoading = false;
            });
            if (state.jwt != null) {
              Timer(Duration(seconds: 3), () {
                Navigator.pop(context);
              });
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                duration: Duration(seconds: 3),
                content: Text('Logged in successfully'),
              ));
            } }else if (state is Registered) {
              setState(() {
                isLoading = false;
              });
              if (state.jwt != null) {
                Timer(Duration(milliseconds: 1500), () {
                  Navigator.pop(context);
                });
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  duration: Duration(milliseconds: 1500),
                  content: Text('Logged in successfully'),
                ));
              }
            
          }
        },
        child: BlocBuilder(
            bloc: AuthBloc(Authenticate()),
            builder: (ctx, state) {
              return Stack(
                children: [
                  anm.Bounce(
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/back.jpg'),
                              fit: BoxFit.cover)),
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
                                              duration:
                                                  Duration(milliseconds: 250),
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
                                              duration:
                                                  Duration(milliseconds: 250),
                                              curve: Curves.linear);
                                        },
                                        child: Text(
                                          'Register',
                                          style: TextStyle(
                                              color: isnot,
                                              fontSize: 18,
                                              fontFamily: 'bree'),
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
                                Form(
                                  key: loginKey,
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(
                                        height: 40,
                                      ),
                                      textField(
                                        hint: 'Enter your E-Mail',
                                        label: 'E-Mail',
                                        obsecured: false,
                                        function: (val) {
                                          if (val.length == 0) {
                                            return 'Please enter your email';
                                          } else if (!Fzregex.hasMatch(
                                              val, FzPattern.email)) {
                                            return 'Please enter a valid email format';
                                          }
                                        },
                                        onChange: (val) {
                                          setState(() {
                                            loginEmail = val;
                                          });
                                        },
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      textField(
                                        hint: 'Enter your password',
                                        label: 'password',
                                        onChange: (val) {
                                          loginPassword = val;
                                        },
                                        obsecured: true,
                                        function: (val) {
                                          if (val.length == 0) {
                                            return 'Please enter your Password';
                                          } else if (val.length < 6) {
                                            return 'Passwords always are 6+ characters';
                                          }
                                        },
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          Text(
                                            'forget password?',
                                            style:
                                                TextStyle(color: Colors.pink),
                                          ),
                                          SizedBox(
                                            width: 40,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      LoadingButton(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            color: mainColor),
                                        onPressed: () {
                                          if (loginKey.currentState
                                              .validate()) {
                                            BlocProvider.of<AuthBloc>(context)
                                                .add(AttempLogin(
                                                    loginEmail, loginPassword));
                                          }
                                        },
                                        isLoading: isLoading,
                                        loadingWidget: Loading(
                                          color: Colors.white,
                                          indicator: BallBeatIndicator(),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12, horizontal: 75),
                                          child: Text(
                                            'Login',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      /*    Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 40),
                                        child: ButtonTheme(
                                          buttonColor: mainColor,
                                          height: 60,
                                          minWidth: width,
                                          child: RaisedButton(
                                            onPressed: () {
                                              if (loginKey.currentState
                                                  .validate()) {
                                                BlocProvider.of<AuthBloc>(
                                                        context)
                                                    .add(AttempLogin(loginEmail,
                                                        loginPassword));
                                              }
                                            },
                                            child: Text(
                                              'Login',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                        ),*/

                                      /* ButtonTheme(
                                              buttonColor: mainColor,
                                              height: 60,
                                              minWidth: width,
                                              child: RaisedButton(
                                                onPressed: () {
                                                  if (loginKey.currentState
                                                      .validate()) {
                                                    BlocProvider.of<AuthBloc>(
                                                            context)
                                                        .add(AttempLogin(
                                                            loginEmail,
                                                            loginPassword));
                                                  }
                                                },
                                                child: Text(
                                                  'Login',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                            ),*/
                                      //    ),
                                      SizedBox(
                                        height: 35,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          pageController.animateToPage(1,
                                              duration:
                                                  Duration(milliseconds: 250),
                                              curve: Curves.linear);
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                  ),
                                ), /////////////////////
                                Form(
                                  key: registerKey,
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(
                                        height: 40,
                                      ),
                                      textField(
                                        hint: 'Enter your name',
                                        label: 'User name',
                                        function: (val) {
                                          if (val.length == 0) {
                                            return 'Enter Name';
                                          }
                                        },
                                        onChange: (val) {
                                          setState(() {
                                            registerName = val;
                                          });
                                        },
                                        obsecured: false,
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      textField(
                                        hint: 'Please Enter your E-Mail',
                                        label: 'Email Address',
                                        obsecured: false,
                                        onChange: (val) {
                                          setState(() {
                                            registerEmail = val;
                                          });
                                        },
                                        function: (val) {
                                          if (val.length == 0) {
                                            return 'Please Enter an Email';
                                          } else if (!Fzregex.hasMatch(
                                              val, FzPattern.email)) {
                                            return 'Please enter a valid email format';
                                          }
                                        },
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      textField(
                                        hint: 'Enter your Password',
                                        label: 'password',
                                        onChange: (val) {
                                          setState(() {
                                            registerPassword = val;
                                          });
                                        },
                                        obsecured: true,
                                        function: (val) {
                                          if (val.length == 0) {
                                            return 'Please Enter a Password';
                                          } else if (val.length < 6) {
                                            return 'Please enter 6+ characters';
                                          }
                                        },
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      LoadingButton(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            color: mainColor),
                                        onPressed: () {
                                          if (registerKey.currentState
                                              .validate()) {
                                            BlocProvider.of<AuthBloc>(context)
                                                .add(AttempSignup(
                                                    registerEmail,
                                                    registerPassword,
                                                    registerName));
                                          }
                                        },
                                        isLoading: isLoading,
                                        loadingWidget: Loading(
                                          color: Colors.white,
                                          indicator: BallBeatIndicator(),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12, horizontal: 75),
                                          child: Text(
                                            'Register',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 35,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          pageController.animateToPage(0,
                                              duration:
                                                  Duration(milliseconds: 250),
                                              curve: Curves.linear);
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}

class textField extends StatelessWidget {
  String hint;
  String label;
  bool obsecured;
  Function function;
  Function onChange;
  textField({
    this.hint,
    this.label,
    this.obsecured,
    this.function,
    this.onChange,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: TextFormField(
        onChanged: onChange,
        obscureText: obsecured,
        validator: function,
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
