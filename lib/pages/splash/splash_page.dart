import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: new BoxDecoration(
              image: new DecorationImage(
            image: new AssetImage('assets/images/smarthome_logo.png'),
          )),
        ),
      ),
    );
  }
}
