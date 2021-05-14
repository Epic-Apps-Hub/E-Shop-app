import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading/indicator/ball_scale_indicator.dart';
import 'package:loading/loading.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/blocs/bloc/auth/auth_bloc.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/repos/auth/authRepo.dart';
import 'package:shop_app/views/auth/accountScreen.dart';
import 'package:shop_app/views/auth/authentication.dart';

class UnAuthed extends StatefulWidget {
  final BuildContext mainPageCtx;

  const UnAuthed({Key key, this.mainPageCtx}) : super(key: key);
  @override
  _UnAuthedState createState() => _UnAuthedState();
}

class _UnAuthedState extends State<UnAuthed> {
  AuthBloc authBloc;
  @override
  void initState() {
    authBloc=BlocProvider.of<AuthBloc>(context);
    finct();
    super.initState();
  }

  String jwt;

  void finct() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    jwt = prefs.getString('jwt');
    print(jwt);
    authBloc.add(CheckAuth(jwt));
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return BlocBuilder<AuthBloc, AuthState>(
     // bloc: AuthBloc(Authenticate()),
      builder: (context, state) {
        if (state is AuthLoading) {
          return Container(
            height: _height,
            width: _width,
            child: Center(
              child: Loading(
                color: mainColor,
                indicator: BallScaleIndicator(),
              ),
            ),
          );
        } else if (state is UnAuthorized) {
          return Container(
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
                          color: mainColor,
                          fontFamily: 'Aileron',
                          fontSize: 34),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'You are Not signed in',
                      style: TextStyle(
                          color: mainColor,
                          fontFamily: 'Raleway',
                          fontSize: 18),
                    ),
                  ],
                ),
                SizedBox(
                  height: _height * .03,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28.0),
                  child: GestureDetector(
                    onTap: () {
                      pushNewScreen(context,
                          screen: BlocProvider(
                            create: (context) => AuthBloc(Authenticate()),
                            child: AuthScreen(),
                          ),
                          withNavBar: false,
                          pageTransitionAnimation:
                              PageTransitionAnimation.slideUp);
                    },
                    child: Container(
                      height: _height * .065,
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
                              fontSize: 23),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (state is Authorized) {
          return AccountScreen(state.email,state.name);
        }
        return Container();
      },
    );
  }
}
