import 'package:flutter/material.dart';

class Error2Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/7_Error.png",
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.18,
       
            child: Container(width: MediaQuery.of(context).size.width,
              child: Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("try to search with another keyword",style: TextStyle(fontFamily: 'Raleway'),)],
               // child: ,
              ),
            ),
          )
        ],
      ),
    );
  }
}