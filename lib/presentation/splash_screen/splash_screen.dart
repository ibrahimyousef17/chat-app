import 'dart:async';

import 'package:chat_app/presentation/auth/login/login_screen.dart';
import 'package:chat_app/presentation/utils/app_assets.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
static const String routeName = 'splash screen';

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
    });
    return Container(
      child: Image.asset(AppAssets.splashScreen,fit: BoxFit.fill,width: double.infinity,height: double.infinity,),
    );
  }
}
