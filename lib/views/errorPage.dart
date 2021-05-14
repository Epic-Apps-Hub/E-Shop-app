import 'package:flutter/material.dart';

class Error2Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/searchResult.png",
            fit: BoxFit.cover,
          ),
        
        ],
      ),
    );
  }
}